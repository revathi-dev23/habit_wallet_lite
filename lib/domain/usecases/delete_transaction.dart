import '../../core/usecase.dart';
import '../repositories/transaction_repository.dart';

class DeleteTransaction implements UseCase<void, String> {
  final TransactionRepository repository;

  DeleteTransaction(this.repository);

  @override
  Future<Result<void>> call(String id) async {
    return repository.deleteTransaction(id);
  }
}
