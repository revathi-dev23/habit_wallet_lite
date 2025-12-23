import 'package:drift/drift.dart';
import 'dart:async' show unawaited;
import 'dart:convert';
import '../../core/failure.dart';
import '../../core/usecase.dart';
import '../../domain/entities/category.dart' as domain_cat;
import '../../domain/entities/transaction.dart' as domain;
import '../../domain/repositories/transaction_repository.dart';
import '../datasources/local/app_database.dart';
import '../datasources/remote/mock_api_service.dart';
import '../services/sync_service.dart';

class TransactionRepositoryImpl implements TransactionRepository {
  final AppDatabase _db;
  final MockApiService _api;
  final SyncService _syncService;

  TransactionRepositoryImpl(this._db, this._api, this._syncService);

  @override
  Future<Result<List<domain.Transaction>>> getTransactions() async {
    try {
      final dbTransactions = await _db.select(_db.transactions).get();
      // Join with categories ideally, or just map simply for now since "category" is just a string in the simple schema
      // In a real app we'd do a join.
      
      final domainTransactions = dbTransactions.map((t) {
        return domain.Transaction(
          id: t.id,
          amount: t.amount,
          category: domain_cat.Category(id: t.category, name: t.category, icon: 'category'), // Placeholder category object
          date: t.date,
          note: t.note,
          isSynced: t.isSynced,
          editedLocally: t.editedLocally,
          lastModified: t.lastModified,
          attachments: (jsonDecode(t.attachments) as List).cast<String>(),
        );
      }).toList();
      
      return Success(domainTransactions);
    } catch (e) {
      return Error(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Result<void>> addTransaction(domain.Transaction transaction) async {
    try {
      await _db.into(_db.transactions).insert(
        TransactionsCompanion(
          id: Value(transaction.id),
          amount: Value(transaction.amount),
          category: Value(transaction.category.name),
          date: Value(transaction.date),
          note: Value(transaction.note),
          attachments: Value(jsonEncode(transaction.attachments)),
          isSynced: const Value(false), // Needs sync
          lastModified: Value(DateTime.now()),
        )
      );
      // Trigger background sync (fire and forget)
      unawaited(_syncService.syncAll());
      
      return Success(null);
    } catch (e) {
      return Error(CacheFailure(e.toString()));
    }
  }



  @override
  Future<Result<void>> deleteTransaction(String id) async {
    try {
      await (_db.delete(_db.transactions)..where((tbl) => tbl.id.equals(id))).go();
      // Optionally sync deletion to API (fire and forget)
      unawaited(_api.syncTransaction({"id": id, "deleted": true}));
      return Success(null);
    } catch (e) {
      return Error(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Result<void>> syncData() async {
    try {
      // Delegate to SyncService
      final success = await _syncService.syncAll();
      return success ? Success(null) : Error(const ServerFailure('Sync failed'));
    } catch (e) {
      return Error(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Result<void>> updateTransaction(domain.Transaction transaction) async {
    try {
      final now = DateTime.now();
      // Mark as edited and set new lastModified
      await (_db.update(_db.transactions)..where((tbl) => tbl.id.equals(transaction.id)))
        .write(TransactionsCompanion(
          amount: Value(transaction.amount),
          category: Value(transaction.category.name),
          date: Value(transaction.date),
          note: Value(transaction.note),
          attachments: Value(jsonEncode(transaction.attachments)),
          isSynced: const Value(false),
          editedLocally: const Value(true),
          lastModified: Value(now),
        ));
      
      // Trigger background sync
      unawaited(_syncService.syncAll());
      
      return Success(null);
    } catch (e) {
      return Error(CacheFailure(e.toString()));
    }
  }
}
