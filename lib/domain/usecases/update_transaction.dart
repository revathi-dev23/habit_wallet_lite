import '../entities/transaction.dart';
import '../repositories/transaction_repository.dart';
import '../../core/usecase.dart';

class UpdateTransaction implements UseCase<void, Transaction> {
  final TransactionRepository repository;

  UpdateTransaction(this.repository);

  @override
  Future<Result<void>> call(Transaction transaction) {
    return repository.updateTransaction(transaction);
  }
}
