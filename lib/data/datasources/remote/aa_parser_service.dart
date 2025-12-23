import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:uuid/uuid.dart';

/// Service to parse Account Aggregator (AA) JSON schema into our app's internal format
class AaParserService {
  static const _uuid = Uuid();

  /// Map raw AA JSON to our internal Map<String, dynamic> structure for MockApiService
  static List<Map<String, dynamic>> parseAaJson(String jsonString) {
    try {
      final Map<String, dynamic> data = jsonDecode(jsonString);
      final List<Map<String, dynamic>> flatTransactions = [];

      // Navigate through the BARB0KIMXXX (IFSC) key
      data.forEach((ifsc, accountList) {
        if (accountList is List) {
          for (var accountEntry in accountList) {
            final transactionsList = accountEntry['decrypted_data']?['Account']?['Transactions']?['Transaction'];
            
            if (transactionsList is List) {
              for (var tx in transactionsList) {
                flatTransactions.add(_mapTx(tx));
              }
            }
          }
        }
      });

      return flatTransactions;
    } catch (e) {
      debugPrint('Error parsing AA JSON: $e');
      return [];
    }
  }

  static Map<String, dynamic> _mapTx(Map<String, dynamic> tx) {
    final double amount = double.tryParse(tx['amount']?.toString() ?? '0.0') ?? 0.0;
    final bool isDebit = tx['type'] == 'DEBIT';
    final String narration = tx['narration'] ?? '';
    final String timestamp = tx['transactionTimestamp'] ?? DateTime.now().toIso8601String();

    return {
      "id": tx['txnId']?.toString().isNotEmpty == true ? tx['txnId'] : _uuid.v4(),
      "amount": isDebit ? -amount : amount,
      "category": _guessCategory(narration),
      "ts": timestamp,
      "note": narration,
      "attachments": "[]",
      "lastModified": timestamp
    };
  }

  static String _guessCategory(String narration) {
    final lower = narration.toLowerCase();
    if (lower.contains('salary')) return 'Salary';
    if (lower.contains('bharatpe') || lower.contains('upi') || lower.contains('amazon') || lower.contains('myntra')) return 'Shopping';
    if (lower.contains('tution')) return 'Education';
    if (lower.contains('food') || lower.contains('zomato') || lower.contains('swiggy')) return 'Food';
    if (lower.contains('petroleum') || lower.contains('fuel')) return 'Fuel';
    if (lower.contains('policybazaar') || lower.contains('insurance')) return 'Insurance';
    if (lower.contains('mutualfunds') || lower.contains('dividend')) return 'Investment';
    if (lower.contains('rent')) return 'Rent';
    if (lower.contains('electricity') || lower.contains('mseb')) return 'Bills';
    if (lower.contains('atm') || lower.contains('atw')) return 'Cash';
    if (lower.contains('itr') || lower.contains('tax')) return 'Taxes';
    if (lower.contains('alert') || lower.contains('charge') || lower.contains('chrg')) return 'Fees';
    return 'Other';
  }
}
