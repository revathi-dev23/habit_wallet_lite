import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:habit_wallet_lite/core/usecase.dart';
import 'package:habit_wallet_lite/core/failure.dart';
import 'package:habit_wallet_lite/domain/entities/transaction.dart';
import 'package:habit_wallet_lite/domain/entities/category.dart';
import 'package:habit_wallet_lite/domain/repositories/transaction_repository.dart';
import 'package:habit_wallet_lite/domain/usecases/add_transaction.dart';

class MockTransactionRepository extends Mock implements TransactionRepository {}

void main() {
  late AddTransaction useCase;
  late MockTransactionRepository mockRepository;

  setUp(() {
    mockRepository = MockTransactionRepository();
    useCase = AddTransaction(mockRepository);
  });

  setUpAll(() {
    // Register fallback values for mocktail
    registerFallbackValue(Transaction(
      id: 'fallback',
      amount: 0.0,
      category: const Category(id: 'test', name: 'Test', icon: 'test'),
      date: DateTime.now(),
      note: '',
    ));
  });

  group('AddTransaction', () {
    final tTransaction = Transaction(
      id: '123',
      amount: -250.0,
      category: const Category(id: 'food', name: 'Food', icon: 'fastfood'),
      date: DateTime(2025, 12, 22),
      note: 'Coffee and snacks',
    );

    test('should add transaction to repository successfully', () async {
      // arrange
      when(() => mockRepository.addTransaction(any()))
          .thenAnswer((_) async => Success(null));

      // act
      final result = await useCase(tTransaction);

      // assert
      expect(result, isA<Success>());
      verify(() => mockRepository.addTransaction(any())).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('should return error when repository fails to add', () async {
      // arrange
      when(() => mockRepository.addTransaction(any()))
          .thenAnswer((_) async => Error(const CacheFailure('Failed to add')));

      // act
      final result = await useCase(tTransaction);

      // assert
      expect(result, isA<Error>());
      expect((result as Error).failure, isA<CacheFailure>());
      verify(() => mockRepository.addTransaction(any())).called(1);
    });

    test('should handle transaction with positive amount (income)', () async {
      // arrange
      final incomeTransaction = Transaction(
        id: '456',
        amount: 5000.0,
        category: const Category(id: 'salary', name: 'Salary', icon: 'payment'),
        date: DateTime(2025, 12, 1),
        note: 'Monthly salary',
      );

      when(() => mockRepository.addTransaction(any()))
          .thenAnswer((_) async => Success(null));

      // act
      final result = await useCase(incomeTransaction);

      // assert
      expect(result, isA<Success>());
      verify(() => mockRepository.addTransaction(incomeTransaction)).called(1);
    });
  });
}
