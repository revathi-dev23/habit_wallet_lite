import 'package:flutter_test/flutter_test.dart';
import 'package:habit_wallet_lite/domain/entities/transaction.dart';
import 'package:habit_wallet_lite/domain/entities/category.dart';

void main() {
  group('Transaction Model', () {
    test('should support value equality', () {
      final t1 = Transaction(
        id: '1',
        amount: 100,
        category: const Category(id: '1', name: 'Food', icon: 'aaa'),
        date: DateTime(2023, 1, 1),
        note: 'Test',
      );
      final t2 = Transaction(
        id: '1',
        amount: 100,
        category: const Category(id: '1', name: 'Food', icon: 'aaa'),
        date: DateTime(2023, 1, 1),
        note: 'Test',
      );

      expect(t1, t2);
    });

    test('should support copyWith for editing', () {
      final original = Transaction(
        id: '1',
        amount: -100.0,
        category: const Category(id: 'food', name: 'Food', icon: 'fastfood'),
        date: DateTime(2023, 1, 1),
        note: 'Original',
        isSynced: true,
      );

      final edited = original.copyWith(
        note: 'Edited',
        editedLocally: true,
      );

      expect(edited.id, original.id);
      expect(edited.note, 'Edited');
      expect(edited.editedLocally, true);
      expect(edited.isSynced, true);
    });

    test('should handle negative amounts for expenses', () {
      final expense = Transaction(
        id: '1',
        amount: -250.0,
        category: const Category(id: 'food', name: 'Food', icon: 'fastfood'),
        date: DateTime(2023, 1, 1),
        note: 'Lunch',
      );

      expect(expense.amount, lessThan(0));
    });

    test('should handle positive amounts for income', () {
      final income = Transaction(
        id: '2',
        amount: 5000.0,
        category: const Category(id: 'salary', name: 'Salary', icon: 'payment'),
        date: DateTime(2023, 1, 1),
        note: 'Monthly salary',
      );

      expect(income.amount, greaterThan(0));
    });

    test('should default editedLocally to false', () {
      final transaction = Transaction(
        id: '1',
        amount: -100.0,
        category: const Category(id: 'food', name: 'Food', icon: 'fastfood'),
        date: DateTime(2023, 1, 1),
        note: 'Test',
      );

      expect(transaction.editedLocally, false);
    });

    test('should default isSynced to false', () {
      final transaction = Transaction(
        id: '1',
        amount: -100.0,
        category: const Category(id: 'food', name: 'Food', icon: 'fastfood'),
        date: DateTime(2023, 1, 1),
        note: 'Test',
      );

      expect(transaction.isSynced, false);
    });

    test('should support attachments list', () {
      final transaction = Transaction(
        id: '1',
        amount: -100.0,
        category: const Category(id: 'food', name: 'Food', icon: 'fastfood'),
        date: DateTime(2023, 1, 1),
        note: 'Test',
        attachments: ['file1.jpg', 'file2.pdf'],
      );

      expect(transaction.attachments.length, 2);
      expect(transaction.attachments, contains('file1.jpg'));
    });
  });

  group('Category Model', () {
    test('should support value equality', () {
      const c1 = Category(id: '1', name: 'Food', icon: 'fastfood');
      const c2 = Category(id: '1', name: 'Food', icon: 'fastfood');

      expect(c1, c2);
    });

    test('should default isCustom to false', () {
      const category = Category(id: '1', name: 'Food', icon: 'fastfood');

      expect(category.isCustom, false);
    });

    test('should support custom categories', () {
      const category = Category(
        id: 'custom-1',
        name: 'My Custom Category',
        icon: 'custom',
        isCustom: true,
      );

      expect(category.isCustom, true);
    });
  });
}
