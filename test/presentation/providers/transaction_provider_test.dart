import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mocktail/mocktail.dart';
import 'package:habit_wallet_lite/core/usecase.dart';
import 'package:habit_wallet_lite/core/failure.dart';
import 'package:habit_wallet_lite/domain/entities/transaction.dart';
import 'package:habit_wallet_lite/domain/entities/category.dart';
import 'package:habit_wallet_lite/domain/usecases/get_transactions.dart';
import 'package:habit_wallet_lite/domain/usecases/add_transaction.dart';
import 'package:habit_wallet_lite/domain/usecases/update_transaction.dart';
import 'package:habit_wallet_lite/domain/usecases/sync_data.dart';
import 'package:habit_wallet_lite/core/notifications/notification_service.dart';
import 'package:habit_wallet_lite/presentation/providers/providers.dart';
import 'package:habit_wallet_lite/presentation/providers/transaction_provider.dart';

class MockGetTransactions extends Mock implements GetTransactions {}
class MockAddTransaction extends Mock implements AddTransaction {}
class MockUpdateTransaction extends Mock implements UpdateTransaction {}
class MockSyncDataUseCase extends Mock implements SyncDataUseCase {}
class MockNotificationService extends Mock implements NotificationService {}

void main() {
  late MockGetTransactions mockGetTransactions;
  late MockAddTransaction mockAddTransaction;
  late MockUpdateTransaction mockUpdateTransaction;
  late MockSyncDataUseCase mockSyncDataUseCase;
  late MockNotificationService mockNotificationService;

  setUp(() {
    mockGetTransactions = MockGetTransactions();
    mockAddTransaction = MockAddTransaction();
    mockUpdateTransaction = MockUpdateTransaction();
    mockSyncDataUseCase = MockSyncDataUseCase();
    mockNotificationService = MockNotificationService();

    // Default stubs
    when(() => mockSyncDataUseCase(any())).thenAnswer((_) async => Success(null));
    when(() => mockNotificationService.cancelDailyReminder()).thenAnswer((_) async {});
    when(() => mockNotificationService.scheduleDailyReminder()).thenAnswer((_) async {});
  });

  setUpAll(() {
    registerFallbackValue(NoParams());
    registerFallbackValue(Transaction(
      id: 'fallback',
      amount: 0.0,
      category: const Category(id: 'test', name: 'Test', icon: 'test'),
      date: DateTime.now(),
      note: '',
    ));
  });

  group('TransactionList Provider', () {
    final tTransactions = [
      Transaction(
        id: '1',
        amount: -100.0,
        category: const Category(id: 'food', name: 'Food', icon: 'fastfood'),
        date: DateTime(2025, 12, 22),
        note: 'Lunch',
        isSynced: true,
      ),
      Transaction(
        id: '2',
        amount: 5000.0,
        category: const Category(id: 'salary', name: 'Salary', icon: 'payment'),
        date: DateTime(2025, 12, 1),
        note: 'Monthly salary',
        isSynced: true,
      ),
    ];

    test('should return list of transactions when initialized', () async {
      final container = ProviderContainer(
        overrides: [
          getTransactionsUseCaseProvider.overrideWithValue(mockGetTransactions),
          syncDataUseCaseProvider.overrideWithValue(mockSyncDataUseCase),
        ],
      );

      when(() => mockGetTransactions(any()))
          .thenAnswer((_) async => Success(tTransactions));

      final state = await container.read(transactionListProvider.future);

      expect(state, tTransactions);
      verify(() => mockGetTransactions(NoParams())).called(1);

      container.dispose();
    });

    test('should handle empty transaction list', () async {
      final container = ProviderContainer(
        overrides: [
          getTransactionsUseCaseProvider.overrideWithValue(mockGetTransactions),
          syncDataUseCaseProvider.overrideWithValue(mockSyncDataUseCase),
        ],
      );

      when(() => mockGetTransactions(any()))
          .thenAnswer((_) async => Success(const <Transaction>[]));

      final state = await container.read(transactionListProvider.future);

      expect(state, isEmpty);

      container.dispose();
    });

    test('should throw exception when use case returns error', () async {
      final container = ProviderContainer(
        overrides: [
          getTransactionsUseCaseProvider.overrideWithValue(mockGetTransactions),
          syncDataUseCaseProvider.overrideWithValue(mockSyncDataUseCase),
        ],
      );

      when(() => mockGetTransactions(any()))
          .thenAnswer((_) async => Error(const CacheFailure('Failed')));

      expect(
        () => container.read(transactionListProvider.future),
        throwsA(isA<Exception>()),
      );

      container.dispose();
    });

    test('should add transaction and refresh list', () async {
      final container = ProviderContainer(
        overrides: [
          getTransactionsUseCaseProvider.overrideWithValue(mockGetTransactions),
          addTransactionUseCaseProvider.overrideWithValue(mockAddTransaction),
          syncDataUseCaseProvider.overrideWithValue(mockSyncDataUseCase),
          notificationServiceProvider.overrideWithValue(mockNotificationService),
        ],
      );

      final newTransaction = Transaction(
        id: '3',
        amount: -50.0,
        category: const Category(id: 'travel', name: 'Travel', icon: 'flight'),
        date: DateTime(2025, 12, 22),
        note: 'Bus fare',
      );

      when(() => mockGetTransactions(any()))
          .thenAnswer((_) async => Success(tTransactions));
      when(() => mockAddTransaction(any()))
          .thenAnswer((_) async => Success(null));

      final notifier = container.read(transactionListProvider.notifier);
      await notifier.addTransaction(newTransaction);

      verify(() => mockAddTransaction(newTransaction)).called(1);
      verify(() => mockGetTransactions(NoParams())).called(greaterThan(1));

      container.dispose();
    });

    test('should update transaction and refresh list', () async {
      final container = ProviderContainer(
        overrides: [
          getTransactionsUseCaseProvider.overrideWithValue(mockGetTransactions),
          updateTransactionUseCaseProvider.overrideWithValue(mockUpdateTransaction),
          syncDataUseCaseProvider.overrideWithValue(mockSyncDataUseCase),
        ],
      );

      final updatedTransaction = tTransactions[0].copyWith(
        note: 'Updated lunch',
        editedLocally: true,
      );

      when(() => mockGetTransactions(any()))
          .thenAnswer((_) async => Success(tTransactions));
      when(() => mockUpdateTransaction(any()))
          .thenAnswer((_) async => Success(null));

      final notifier = container.read(transactionListProvider.notifier);
      await notifier.updateTransaction(updatedTransaction);

      verify(() => mockUpdateTransaction(updatedTransaction)).called(1);
      verify(() => mockGetTransactions(NoParams())).called(greaterThan(1));

      container.dispose();
    });

    test('should set error state when add fails', () async {
      final container = ProviderContainer(
        overrides: [
          getTransactionsUseCaseProvider.overrideWithValue(mockGetTransactions),
          addTransactionUseCaseProvider.overrideWithValue(mockAddTransaction),
          syncDataUseCaseProvider.overrideWithValue(mockSyncDataUseCase),
          notificationServiceProvider.overrideWithValue(mockNotificationService),
        ],
      );

      final newTransaction = Transaction(
        id: '3',
        amount: -50.0,
        category: const Category(id: 'travel', name: 'Travel', icon: 'flight'),
        date: DateTime(2025, 12, 22),
        note: 'Bus fare',
      );

      when(() => mockGetTransactions(any()))
          .thenAnswer((_) async => Success(tTransactions));
      when(() => mockAddTransaction(any()))
          .thenAnswer((_) async => Error(const CacheFailure('Add failed')));

      final notifier = container.read(transactionListProvider.notifier);
      await notifier.addTransaction(newTransaction);

      final state = container.read(transactionListProvider);
      expect(state.hasError, true);

      container.dispose();
    });
  });
}
