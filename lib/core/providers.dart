import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/datasources/local/app_database.dart';
import '../data/datasources/remote/mock_api_service.dart';
import '../data/services/sync_service.dart';
import '../data/repositories/transaction_repository_impl.dart';
import '../domain/repositories/transaction_repository.dart';
import '../domain/entities/sync_status.dart';

/// Database provider
final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(() => db.close());
  return db;
});

/// Mock API service provider
final apiServiceProvider = Provider<MockApiService>((ref) {
  return MockApiService();
});

/// Sync service provider
final syncServiceProvider = Provider<SyncService>((ref) {
  final db = ref.watch(databaseProvider);
  final api = ref.watch(apiServiceProvider);
  final syncService = SyncService(db, api);
  
  // Start periodic sync when app starts
  syncService.startPeriodicSync();
  
  ref.onDispose(() {
    syncService.stopPeriodicSync();
    syncService.dispose();
  });
  
  return syncService;
});

/// Transaction repository provider
final transactionRepositoryProvider = Provider<TransactionRepository>((ref) {
  final db = ref.watch(databaseProvider);
  final api = ref.watch(apiServiceProvider);
  final syncService = ref.watch(syncServiceProvider);
  
  return TransactionRepositoryImpl(db, api, syncService);
});

/// Sync status notifier provider
final syncStatusProvider = Provider<ValueNotifier<SyncStatus>>((ref) {
  return ref.watch(syncServiceProvider).syncStatus;
});

/// Pending sync count provider (updates every minute or when triggered)
final pendingSyncCountProvider = StreamProvider<int>((ref) async* {
  final syncService = ref.watch(syncServiceProvider);
  
  while (true) {
    yield await syncService.getPendingSyncCount();
    await Future.delayed(const Duration(seconds: 30));
  }
});

/// Manual sync trigger
final manualSyncProvider = FutureProvider.autoDispose<bool>((ref) async {
  final syncService = ref.watch(syncServiceProvider);
  return syncService.syncAll();
});

