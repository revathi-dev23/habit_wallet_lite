import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:habit_wallet_lite/core/usecase.dart';
import 'package:habit_wallet_lite/domain/entities/transaction.dart';
import 'package:habit_wallet_lite/domain/entities/category.dart';
import 'package:habit_wallet_lite/domain/repositories/transaction_repository.dart';
import 'package:habit_wallet_lite/domain/usecases/transaction/get_transactions.dart';

class MockTransactionRepository extends Mock implements TransactionRepository {}

void main() {
  late GetTransactions useCase;
  late MockTransactionRepository mockRepository;

  setUp(() {
    mockRepository = MockTransactionRepository();
    useCase = GetTransactions(mockRepository);
  });

  group('GetTransactions', () {
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

    test('should get transactions from repository', () async {
      // arrange
      when(() => mockRepository.getTransactions())
          .thenAnswer((_) async => Success(tTransactions));

      // act
      final result = await useCase(NoParams());

      // assert
      expect(result, isA<Success<List<Transaction>>>());
      expect((result as Success).data, tTransactions);
      verify(() => mockRepository.getTransactions()).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('should return empty list when no transactions exist', () async {
      // arrange
      when(() => mockRepository.getTransactions())
          .thenAnswer((_) async => Success(const <Transaction>[]));

      // act
      final result = await useCase(NoParams());

      // assert
      expect(result, isA<Success<List<Transaction>>>());
      expect((result as Success).data, isEmpty);
      verify(() => mockRepository.getTransactions()).called(1);
    });

    test('should return error when repository fails', () async {
      // arrange
      when(() => mockRepository.getTransactions())
          .thenAnswer((_) async => Error(CacheFailure('Failed to load')));

      // act
      final result = await useCase(NoParams());

      // assert
      expect(result, isA<Error>());
      expect((result as Error).failure, isA<CacheFailure>());
      verify(() => mockRepository.getTransactions()).called(1);
    });
  });
}
