import 'dart:async' show unawaited, FutureOr;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entities/transaction.dart';
import '../../core/usecase.dart';
import 'providers.dart';

part 'transaction_provider.g.dart';

@riverpod
class TransactionList extends _$TransactionList {
  @override
  FutureOr<List<Transaction>> build() async {
    final transactions = await _fetchTransactions();
    
    // Trigger sync on cold start if local DB is empty
    if (transactions.isEmpty) {
      unawaited(Future.microtask(() => syncData()));
    }
    
    return transactions;
  }

  Future<List<Transaction>> _fetchTransactions() async {
    final getTransactions = ref.read(getTransactionsUseCaseProvider);
    final result = await getTransactions(NoParams());
    
    // Simple handling: return list or throw
    if (result is Success<List<Transaction>>) {
      return result.data;
    } else {
      throw Exception((result as Error).failure.message);
    }
  }

  Future<void> addTransaction(Transaction t) async {
    final addUseCase = ref.read(addTransactionUseCaseProvider);
    state = const AsyncValue.loading();
    
    final result = await addUseCase(t);
    
    if (result is Success) {
      // Cancel today's reminder if any, and schedule for next instance (likely tomorrow)
      final notifications = ref.read(notificationServiceProvider);
      unawaited(notifications.cancelDailyReminder());
      unawaited(notifications.scheduleDailyReminder());

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

  Future<void> deleteTransaction(String id) async {
    final deleteUseCase = ref.read(deleteTransactionUseCaseProvider);
    state = const AsyncValue.loading();
    
    final result = await deleteUseCase(id);
    
    if (result is Success) {
      ref.invalidateSelf();
      await future;
    } else {
      state = AsyncValue.error((result as Error).failure, StackTrace.current);
    }
  }

  Future<void> syncData() async {
    final syncUseCase = ref.read(syncDataUseCaseProvider);
    // Don't set state to loading to avoid blank screen during sync
    // Just perform the sync and invalidate if successful
    
    final result = await syncUseCase(NoParams());
    
    if (result is Success) {
      ref.invalidateSelf();
      await future;
    } else {
      // Only set error if we don't have existing data
      if (!state.hasValue) {
        state = AsyncValue.error((result as Error).failure, StackTrace.current);
      }
    }
  }
}
