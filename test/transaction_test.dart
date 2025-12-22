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
  });
}
