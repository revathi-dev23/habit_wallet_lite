import '../entities/transaction.dart';
import '../../core/usecase.dart';

abstract class TransactionRepository {
  Future<Result<List<Transaction>>> getTransactions();
  Future<Result<void>> addTransaction(Transaction transaction);
  Future<Result<void>> updateTransaction(Transaction transaction);
  Future<Result<void>> deleteTransaction(String id);
  Future<Result<void>> syncData();
}
