import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entities/transaction.dart';
import '../../core/usecase.dart';
import 'providers.dart';

part 'transaction_provider.g.dart';

@riverpod
class TransactionList extends _$TransactionList {
  @override
  FutureOr<List<Transaction>> build() async {
    return _fetchTransactions();
  }

  Future<List<Transaction>> _fetchTransactions() async {
    final getTransactions = ref.read(getTransactionsUseCaseProvider);
    final result = await getTransactions(NoParams());
    
    // Simple handling: return list or throw
    if (result is Success<List<Transaction>>) {
      return result.data;
    } else {
      throw Exception((result as Error).failure);
    }
  }

  Future<void> addTransaction(Transaction t) async {
    final addUseCase = ref.read(addTransactionUseCaseProvider);
    state = const AsyncValue.loading();
    
    final result = await addUseCase(t);
    
    if (result is Success) {
      // Refresh list
      ref.invalidateSelf();
      await future;
    } else {
      state = AsyncValue.error((result as Error).failure, StackTrace.current);
    }
  }

  Future<void> updateTransaction(Transaction t) async {
    final updateUseCase = ref.read(updateTransactionUseCaseProvider);
    state = const AsyncValue.loading();
    
    final result = await updateUseCase(t);
    
    if (result is Success) {
      // Refresh list
      ref.invalidateSelf();
      await future;
    } else {
      state = AsyncValue.error((result as Error).failure, StackTrace.current);
    }
  }
}
