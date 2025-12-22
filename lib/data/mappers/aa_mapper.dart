import '../../domain/entities/category.dart';
import '../../domain/entities/transaction.dart';
import '../models/account_aggregator_models.dart';

class AAMapper {
  static List<Transaction> mapToDomain(AAData data) {
    final aaTxns = data.account.transactions.transactionList;
    
    return aaTxns.map((t) {
      // Logic to categorize based on narration or mode
      final categoryName = _inferCategory(t.narration);
      
      return Transaction(
        id: t.txnId.isEmpty ? DateTime.now().microsecondsSinceEpoch.toString() : t.txnId, // Handle empty IDs in sample
        amount: double.tryParse(t.amount) ?? 0.0,
        category: Category(id: categoryName, name: categoryName, icon: 'category'),
        date: DateTime.parse(t.transactionTimestamp),
        note: t.narration,
        isSynced: true,
      );
    }).toList();
  }

  static String _inferCategory(String narration) {
    if (narration.toLowerCase().contains('food') || narration.toLowerCase().contains('bharatpe')) return 'Food';
    if (narration.toLowerCase().contains('salary')) return 'Salary';
    if (narration.toLowerCase().contains('fee')) return 'Bills';
    return 'Other';
  }
}
