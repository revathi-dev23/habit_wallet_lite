import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import 'dart:async' show unawaited;
import '../../core/failure.dart';
import '../../core/usecase.dart';
import '../../domain/entities/category.dart' as domain_cat;
import '../../domain/entities/transaction.dart' as domain;
import '../../domain/repositories/transaction_repository.dart';
import '../datasources/local/app_database.dart';
import '../datasources/remote/mock_api_service.dart';

class TransactionRepositoryImpl implements TransactionRepository {
  final AppDatabase _db;
  final MockApiService _api;

  TransactionRepositoryImpl(this._db, this._api);

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
          attachments: [], // TODO: Parse JSON string if needed
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
          isSynced: const Value(false), // Needs sync
          lastModified: Value(DateTime.now()),
        )
      );
      // Trigger background sync (fire and forget for this lite version, or use a queue)
      unawaited(_syncOne(transaction));
      
      return Success(null);
    } catch (e) {
      return Error(CacheFailure(e.toString()));
    }
  }

  Future<void> _syncOne(domain.Transaction t) async {
    try {
      // Map domain to JSON
      final json = {
        "id": t.id,
        "amount": t.amount,
        "category": t.category.name,
        "ts": t.date.toIso8601String(),
        "note": t.note
      };
      unawaited(_api.syncTransaction(json));
      // Update local DB to set isSynced = true and clear editedLocally
      unawaited((_db.update(_db.transactions)..where((tbl) => tbl.id.equals(t.id)))
            .write(const TransactionsCompanion(
              isSynced: Value(true),
              editedLocally: Value(false),
            )));
    } catch (e) {
      // Sync failed, retry later
      // Logging without print for production
      debugPrint("Sync failed for ${t.id}: $e");
    }
  }

  @override
  Future<Result<void>> deleteTransaction(String id) async {
      // Implement delete
      return Success(null);
  }

  @override
  Future<Result<void>> syncData() async {
    // Implement full sync
    return Success(null);
  }
  
  @override
  Future<Result<void>> updateTransaction(domain.Transaction transaction) async {
    try {
      // Check if transaction was previously synced
      final existing = await (_db.select(_db.transactions)
        ..where((tbl) => tbl.id.equals(transaction.id))).getSingleOrNull();
      
      final wasAlreadySynced = existing?.isSynced ?? false;
      
      await (_db.update(_db.transactions)..where((tbl) => tbl.id.equals(transaction.id)))
        .write(TransactionsCompanion(
          amount: Value(transaction.amount),
          category: Value(transaction.category.name),
          date: Value(transaction.date),
          note: Value(transaction.note),
          isSynced: const Value(false), // Needs to be re-synced
          editedLocally: Value(wasAlreadySynced), // Mark as edited if previously synced
          lastModified: Value(DateTime.now()),
        )) // ignore: prefer_const_constructors
        ;
      
      // Trigger sync
      unawaited(_syncOne(transaction));
      
      // ignore: prefer_const_constructors
      return Success(null);
    } catch (e) {
      return Error(CacheFailure(e.toString()));
    }
  }
}
