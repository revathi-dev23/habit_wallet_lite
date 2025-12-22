import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:habit_wallet_lite/domain/entities/transaction.dart';
import 'package:habit_wallet_lite/domain/entities/category.dart';
import 'package:habit_wallet_lite/domain/repositories/transaction_repository.dart';
import 'package:habit_wallet_lite/domain/usecases/transaction/update_transaction.dart';

class MockTransactionRepository extends Mock implements TransactionRepository {}

void main() {
  late UpdateTransaction useCase;
  late MockTransactionRepository mockRepository;

  setUp(() {
    mockRepository = MockTransactionRepository();
    useCase = UpdateTransaction(mockRepository);
  });

  setUpAll(() {
    registerFallbackValue(Transaction(
      id: 'fallback',
      amount: 0.0,
      category: const Category(id: 'test', name: 'Test', icon: 'test'),
      date: DateTime.now(),
      note: '',
    ));
  });

  group('UpdateTransaction', () {
    final tTransaction = Transaction(
      id: '123',
      amount: -300.0,
      category: const Category(id: 'food', name: 'Food', icon: 'fastfood'),
      date: DateTime(2025, 12, 22),
      note: 'Updated: Dinner',
      isSynced: false,
      editedLocally: true,
    );

    test('should update transaction in repository successfully', () async {
      // arrange
      when(() => mockRepository.updateTransaction(any()))
          .thenAnswer((_) async => Success(null));

      // act
      final result = await useCase(tTransaction);

      // assert
      expect(result, isA<Success>());
      verify(() => mockRepository.updateTransaction(tTransaction)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('should return error when repository fails to update', () async {
      // arrange
      when(() => mockRepository.updateTransaction(any()))
          .thenAnswer((_) async => Error(CacheFailure('Failed to update')));

      // act
      final result = await useCase(tTransaction);

      // assert
      expect(result, isA<Error>());
      expect((result as Error).failure, isA<CacheFailure>());
      verify(() => mockRepository.updateTransaction(tTransaction)).called(1);
    });

    test('should handle updating transaction with editedLocally flag', () async {
      // arrange
      final editedTransaction = Transaction(
        id: '789',
        amount: -150.0,
        category: const Category(id: 'travel', name: 'Travel', icon: 'flight'),
        date: DateTime(2025, 12, 20),
        note: 'Bus fare - edited',
        isSynced: false,
        editedLocally: true,
        lastModified: DateTime.now(),
      );

      when(() => mockRepository.updateTransaction(any()))
          .thenAnswer((_) async => Success(null));

      // act
      final result = await useCase(editedTransaction);

      // assert
      expect(result, isA<Success>());
      verify(() => mockRepository.updateTransaction(editedTransaction)).called(1);
    });

    test('should handle conflict resolution (last-write-wins)', () async {
      // arrange
      final conflictedTransaction = Transaction(
        id: 'conflict-123',
        amount: -500.0,
        category: const Category(id: 'bills', name: 'Bills', icon: 'receipt'),
        date: DateTime(2025, 12, 15),
        note: 'Electricity bill - resolved',
        isSynced: false,
        editedLocally: true,
        lastModified: DateTime.now(),
      );

      when(() => mockRepository.updateTransaction(any()))
          .thenAnswer((_) async => Success(null));

      // act
      final result = await useCase(conflictedTransaction);

      // assert
      expect(result, isA<Success>());
      verify(() => mockRepository.updateTransaction(conflictedTransaction)).called(1);
    });
  });
}
