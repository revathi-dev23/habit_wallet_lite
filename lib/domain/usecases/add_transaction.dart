import '../../core/usecase.dart';
import '../entities/transaction.dart';
import '../repositories/transaction_repository.dart';

class AddTransaction implements UseCase<void, Transaction> {
  final TransactionRepository repository;

  AddTransaction(this.repository);

  @override
  Future<Result<void>> call(Transaction params) {
    return repository.addTransaction(params);
  }
}
