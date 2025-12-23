import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasources/local/app_database.dart';
import '../../data/datasources/remote/mock_api_service.dart';
import '../../data/repositories/transaction_repository_impl.dart';
import '../../data/services/sync_service.dart';
import '../../domain/repositories/transaction_repository.dart';
import '../../domain/usecases/add_transaction.dart';
import '../../domain/usecases/get_transactions.dart';
import '../../domain/usecases/update_transaction.dart';
import '../../domain/usecases/delete_transaction.dart';
import '../../domain/usecases/sync_data.dart';
import '../../core/notifications/notification_service.dart';

final notificationServiceProvider = Provider<NotificationService>((ref) {
  return NotificationService();
});

// Data Sources
final appDatabaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(() => db.close());
  return db;
});

final mockApiServiceProvider = Provider<MockApiService>((ref) {
  return MockApiService();
});

// Sync Service
final syncServiceProvider = Provider<SyncService>((ref) {
  final db = ref.watch(appDatabaseProvider);
  final api = ref.watch(mockApiServiceProvider);
  final syncService = SyncService(db, api);
  
  // Start periodic sync
  syncService.startPeriodicSync();
  
  ref.onDispose(() {
    syncService.stopPeriodicSync();
    syncService.dispose();
  });
  
  return syncService;
});

// Repository
final transactionRepositoryProvider = Provider<TransactionRepository>((ref) {
  final db = ref.watch(appDatabaseProvider);
  final api = ref.watch(mockApiServiceProvider);
  final syncService = ref.watch(syncServiceProvider);
  return TransactionRepositoryImpl(db, api, syncService);
});

// Use Cases
final getTransactionsUseCaseProvider = Provider<GetTransactions>((ref) {
  return GetTransactions(ref.watch(transactionRepositoryProvider));
});

final addTransactionUseCaseProvider = Provider<AddTransaction>((ref) {
  return AddTransaction(ref.watch(transactionRepositoryProvider));
});

final updateTransactionUseCaseProvider = Provider<UpdateTransaction>((ref) {
  return UpdateTransaction(ref.watch(transactionRepositoryProvider));
});

final deleteTransactionUseCaseProvider = Provider<DeleteTransaction>((ref) {
  return DeleteTransaction(ref.watch(transactionRepositoryProvider));
});

final syncDataUseCaseProvider = Provider<SyncDataUseCase>((ref) {
  return SyncDataUseCase(ref.watch(transactionRepositoryProvider));
});
