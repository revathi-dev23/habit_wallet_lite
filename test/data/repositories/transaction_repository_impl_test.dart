import 'package:flutter_test/flutter_test.dart';
import 'package:habit_wallet_lite/data/datasources/remote/mock_api_service.dart';

void main() {
  late MockApiService apiService;

  setUp(() {
    apiService = MockApiService();
  });

  group('MockApiService', () {
    test('getTransactions returns mock transaction data', () async {
      // act
      final transactions = await apiService.getTransactions();

      // assert
      expect(transactions, isNotEmpty);
      expect(transactions.length, greaterThan(10)); // Sample has many items
      final firstTx = transactions[0];
      expect(firstTx['id'], isA<String>());
      expect(firstTx['id'], isNotEmpty);
      expect(firstTx['category'], 'Shopping'); // Based on first item in aa_json_data.dart
      expect(firstTx['amount'], -180.0);
    });

    test('getCategories returns list of categories as maps', () async {
      // act
      final categories = await apiService.getCategories();

      // assert
      expect(categories, isNotEmpty);
      // We have 6 hardcoded categories in MockApiService
      expect(categories.length, 6);
      expect(categories[0]['name'], 'Food');
      expect(categories[1]['name'], 'Travel');
    });

    test('syncTransaction completes successfully', () async {
      // arrange
      final transactionJson = {
        'id': 't1',
        'amount': -100.0,
        'category': 'Food',
        'ts': '2025-12-22T12:00:00Z',
        'note': 'Test',
      };

      // act & assert
      await apiService.syncTransaction(transactionJson);
    });
  });
}
