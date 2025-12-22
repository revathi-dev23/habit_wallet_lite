import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasources/local/app_database.dart';
import '../../data/datasources/remote/mock_api_service.dart';
import '../../data/repositories/transaction_repository_impl.dart';
import '../../domain/repositories/transaction_repository.dart';
import '../../domain/usecases/add_transaction.dart';
import '../../domain/usecases/get_transactions.dart';
import '../../domain/usecases/update_transaction.dart';

// Data Sources
final appDatabaseProvider = Provider<AppDatabase>((ref) {
  return AppDatabase();
});

final mockApiServiceProvider = Provider<MockApiService>((ref) {
  return MockApiService();
});

// Repository
final transactionRepositoryProvider = Provider<TransactionRepository>((ref) {
  final db = ref.watch(appDatabaseProvider);
  final api = ref.watch(mockApiServiceProvider);
  return TransactionRepositoryImpl(db, api);
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
