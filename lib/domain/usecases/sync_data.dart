import '../../core/usecase.dart';
import '../repositories/transaction_repository.dart';

class SyncDataUseCase implements UseCase<void, NoParams> {
  final TransactionRepository repository;

  SyncDataUseCase(this.repository);

  @override
  Future<Result<void>> call(NoParams params) async {
    return repository.syncData();
  }
}
