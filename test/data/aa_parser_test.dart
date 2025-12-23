import 'package:flutter_test/flutter_test.dart';
import 'package:habit_wallet_lite/data/datasources/remote/aa_parser_service.dart';
import 'package:habit_wallet_lite/data/datasources/remote/aa_json_data.dart';

void main() {
  group('AaParserService Tests', () {
    test('should parse correctly and return transactions', () {
      final transactions = AaParserService.parseAaJson(sampleBankStatementJson);
      
      expect(transactions.isNotEmpty, true);
      // Based on the data provided, there are around 100+ transactions
      expect(transactions.length, greaterThan(100));
      
      // Check first transaction (Debit)
      final first = transactions.first;
      expect(first['amount'], -180.0);
      expect(first['category'], 'Shopping'); // Narration contains 'BharatPe'
      
      // Check salary transaction
      final salaryTx = transactions.firstWhere((tx) => tx['note'].contains('SALARY'));
      expect(salaryTx['amount'], 30000.0);
      expect(salaryTx['category'], 'Salary');
      
      // Check insurance
      final policyTx = transactions.firstWhere((tx) => tx['note'].contains('POLICYBAZAAR'));
      expect(policyTx['category'], 'Insurance');
    });

    test('should handle empty or invalid JSON gracefully', () {
      final transactions = AaParserService.parseAaJson('{}');
      expect(transactions.isEmpty, true);
      
      final invalid = AaParserService.parseAaJson('invalid');
      expect(invalid.isEmpty, true);
    });
  });
}
