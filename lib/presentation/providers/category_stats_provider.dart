import 'package:collection/collection.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'transaction_provider.dart';

part 'category_stats_provider.g.dart';

class CategoryStat {
  final String category;
  final double total;
  final int count;

  CategoryStat(this.category, this.total, this.count);
}

@riverpod
Future<List<CategoryStat>> categoryStats(Ref ref) async {
  final transactions = await ref.watch(transactionListProvider.future);
  final now = DateTime.now();
  
  // Filter for current month expenses only
  final currentMonthExpenses = transactions.where((t) {
    final tDate = t.date;
    final tAmount = t.amount;
    return tDate.year == now.year && 
           tDate.month == now.month && 
           tAmount < 0; // Expenses only
  });

  // Group by category
  final grouped = groupBy(currentMonthExpenses, (t) => t.category.name);
  
  return grouped.entries.map((entry) {
    final total = entry.value.fold<double>(0.0, (sum, t) => sum + t.amount.abs());
    return CategoryStat(entry.key, total, entry.value.length);
  }).toList()..sort((a, b) => b.total.compareTo(a.total)); // Sort by total desc
}
