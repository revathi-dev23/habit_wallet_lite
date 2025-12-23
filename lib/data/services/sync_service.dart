import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:drift/drift.dart';
import '../../domain/entities/sync_status.dart';
import '../datasources/local/app_database.dart' as db;
import '../datasources/remote/mock_api_service.dart';

/// Background sync service with retry mechanism and conflict resolution
class SyncService {
  final db.AppDatabase _db;
  final MockApiService _api;
  
  Timer? _periodicSyncTimer;
  bool _isSyncing = false;
  
  // Callback for UI updates
  final ValueNotifier<SyncStatus> syncStatus = ValueNotifier(SyncStatus.idle);
  
  SyncService(this._db, this._api);

  /// Start periodic background sync (every 5 minutes)
  void startPeriodicSync() {
    _periodicSyncTimer?.cancel();
    _periodicSyncTimer = Timer.periodic(
      const Duration(minutes: 5),
      (_) => syncAll(),
    );
    debugPrint('🔄 Periodic sync started');
  }

  /// Stop periodic background sync
  void stopPeriodicSync() {
    _periodicSyncTimer?.cancel();
    debugPrint('⏸️ Periodic sync stopped');
  }

  /// Manual sync trigger
  Future<bool> syncAll() async {
    if (_isSyncing) {
      debugPrint('⚠️ Sync already in progress');
      return false;
    }

    _isSyncing = true;
    syncStatus.value = SyncStatus.syncing;

    try {
      debugPrint('🔄 Starting sync...');
      
      // Sync in parallel for better performance
      final results = await Future.wait([
        _syncTransactions(),
        _syncCategories(),
      ]);

      final allSuccess = results.every((result) => result);
      
      if (allSuccess) {
        syncStatus.value = SyncStatus.success;
        debugPrint('✅ Sync completed successfully');
      } else {
        syncStatus.value = SyncStatus.partialFailure;
        debugPrint('⚠️ Sync completed with errors');
      }

      return allSuccess;
    } catch (e) {
      debugPrint('❌ Sync failed: $e');
      syncStatus.value = SyncStatus.failed;
      return false;
    } finally {
      _isSyncing = false;
      // Reset to idle after 2 seconds
      Future.delayed(const Duration(seconds: 2), () {
        if (syncStatus.value != SyncStatus.syncing) {
          syncStatus.value = SyncStatus.idle;
        }
      });
    }
  }

  /// Sync transactions with last-write-wins conflict resolution
  Future<bool> _syncTransactions() async {
    try {
      // 1. Fetch remote transactions
      final remoteData = await _api.getTransactions();
      
      for (final remoteJson in remoteData) {
        await _handleTransactionConflict(remoteJson);
      }

      // 2. Push unsynced local transactions
      final unsynced = await (_db.select(_db.transactions)
        ..where((tbl) => tbl.isSynced.not())).get();
      
      for (final tx in unsynced) {
        await _pushTransaction(tx);
      }

      return true;
    } catch (e) {
      debugPrint('❌ Transaction sync failed: $e');
      return false;
    }
  }

  /// Handle transaction conflict with last-write-wins strategy
  Future<void> _handleTransactionConflict(Map<String, dynamic> remoteJson) async {
    final String id = remoteJson['id'];
    final remoteLastModified = DateTime.parse(remoteJson['lastModified']);
    
    final local = await (_db.select(_db.transactions)
      ..where((tbl) => tbl.id.equals(id))).getSingleOrNull();

    if (local == null) {
      // New remote transaction - insert locally
      await _db.into(_db.transactions).insert(
        db.TransactionsCompanion.insert(
          id: id,
          amount: (remoteJson['amount'] as num).toDouble(),
          category: remoteJson['category'],
          date: DateTime.parse(remoteJson['ts']),
          note: remoteJson['note'] ?? '',
          attachments: Value(remoteJson['attachments'] ?? '[]'),
          isSynced: const Value(true),
          editedLocally: const Value(false),
          lastModified: Value(remoteLastModified),
        ),
      );
      debugPrint('✨ New transaction from remote: $id');
    } else {
      // Conflict exists - apply last-write-wins
      final localLastModified = local.lastModified ?? DateTime.fromMillisecondsSinceEpoch(0);
      
      if (remoteLastModified.isAfter(localLastModified)) {
        // Remote wins - update local
        await (_db.update(_db.transactions)
          ..where((tbl) => tbl.id.equals(id))).write(
          db.TransactionsCompanion(
            amount: Value((remoteJson['amount'] as num).toDouble()),
            category: Value(remoteJson['category']),
            date: Value(DateTime.parse(remoteJson['ts'])),
            note: Value(remoteJson['note'] ?? ''),
            attachments: Value(remoteJson['attachments'] ?? '[]'),
            isSynced: const Value(true),
            editedLocally: const Value(false),
            lastModified: Value(remoteLastModified),
          ),
        );
        debugPrint('🔄 Remote wins for transaction: $id');
      } else if (local.editedLocally && !local.isSynced) {
        // Local has unpushed changes - push to remote
        await _pushTransaction(local);
        debugPrint('⬆️ Local wins, pushing transaction: $id');
      }
    }
  }

  /// Push a single transaction to remote
  Future<void> _pushTransaction(db.Transaction tx) async {
    try {
      final json = {
        "id": tx.id,
        "amount": tx.amount,
        "category": tx.category,
        "ts": tx.date.toIso8601String(),
        "note": tx.note,
        "attachments": tx.attachments,
        "lastModified": DateTime.now().toIso8601String(),
      };

      await _api.syncTransaction(json);

      // Mark as synced
      await (_db.update(_db.transactions)
        ..where((tbl) => tbl.id.equals(tx.id))).write(
        const db.TransactionsCompanion(
          isSynced: Value(true),
          editedLocally: Value(false),
        ),
      );
      
      debugPrint('✅ Pushed transaction: ${tx.id}');
    } catch (e) {
      debugPrint('❌ Failed to push transaction ${tx.id}: $e');
      rethrow;
    }
  }

  /// Sync categories with similar conflict resolution
  Future<bool> _syncCategories() async {
    try {
      // 1. Fetch remote categories
      final remoteData = await _api.getCategories();
      
      for (final remoteJson in remoteData) {
        await _handleCategoryConflict(remoteJson);
      }

      // 2. Push unsynced local categories
      final unsynced = await (_db.select(_db.categories)
        ..where((tbl) => tbl.isSynced.not())).get();
      
      for (final cat in unsynced) {
        await _pushCategory(cat);
      }

      return true;
    } catch (e) {
      debugPrint('❌ Category sync failed: $e');
      return false;
    }
  }

  /// Handle category conflict
  Future<void> _handleCategoryConflict(Map<String, dynamic> remoteJson) async {
    final String id = remoteJson['id'];
    final remoteLastModified = remoteJson['lastModified'] != null
        ? DateTime.parse(remoteJson['lastModified'])
        : DateTime.now();
    
    final local = await (_db.select(_db.categories)
      ..where((tbl) => tbl.id.equals(id))).getSingleOrNull();

    if (local == null) {
      // New remote category
      await _db.into(_db.categories).insert(
        db.CategoriesCompanion.insert(
          id: id,
          name: remoteJson['name'],
          icon: remoteJson['icon'],
          isCustom: Value(remoteJson['isCustom'] ?? false),
          isSynced: const Value(true),
          editedLocally: const Value(false),
          lastModified: Value(remoteLastModified),
        ),
      );
      debugPrint('✨ New category from remote: $id');
    } else {
      // Conflict handling
      final localLastModified = local.lastModified ?? DateTime.fromMillisecondsSinceEpoch(0);
      
      if (remoteLastModified.isAfter(localLastModified)) {
        // Remote wins
        await (_db.update(_db.categories)
          ..where((tbl) => tbl.id.equals(id))).write(
          db.CategoriesCompanion(
            name: Value(remoteJson['name']),
            icon: Value(remoteJson['icon']),
            isSynced: const Value(true),
            editedLocally: const Value(false),
            lastModified: Value(remoteLastModified),
          ),
        );
        debugPrint('🔄 Remote wins for category: $id');
      } else if (local.editedLocally && !local.isSynced) {
        // Local wins - push to remote
        await _pushCategory(local);
        debugPrint('⬆️ Local wins, pushing category: $id');
      }
    }
  }

  /// Push a single category to remote
  Future<void> _pushCategory(db.Category cat) async {
    try {
      final json = {
        "id": cat.id,
        "name": cat.name,
        "icon": cat.icon,
        "isCustom": cat.isCustom,
        "lastModified": DateTime.now().toIso8601String(),
      };

      await _api.syncCategory(json);

      // Mark as synced
      await (_db.update(_db.categories)
        ..where((tbl) => tbl.id.equals(cat.id))).write(
        const db.CategoriesCompanion(
          isSynced: Value(true),
          editedLocally: Value(false),
        ),
      );
      
      debugPrint('✅ Pushed category: ${cat.id}');
    } catch (e) {
      debugPrint('❌ Failed to push category ${cat.id}: $e');
      rethrow;
    }
  }

  /// Get count of items pending sync
  Future<int> getPendingSyncCount() async {
    final transactions = await (_db.select(_db.transactions)
      ..where((tbl) => tbl.isSynced.not())).get();
    
    final categories = await (_db.select(_db.categories)
      ..where((tbl) => tbl.isSynced.not())).get();

    return transactions.length + categories.length;
  }

  void dispose() {
    _periodicSyncTimer?.cancel();
    syncStatus.dispose();
  }
}

