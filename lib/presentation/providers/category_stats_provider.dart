import 'package:collection/collection.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_wallet_lite/presentation/providers/transaction_provider.dart';
import 'package:habit_wallet_lite/presentation/providers/stats_provider.dart';

part 'category_stats_provider.g.dart';

class CategoryStat {
  final String category;
  final String icon;
  final double total;
  final int count;

  CategoryStat(this.category, this.icon, this.total, this.count);
}

@riverpod
Future<List<CategoryStat>> categoryStats(Ref ref) async {
  final transactions = await ref.watch(transactionListProvider.future);
  if (transactions.isEmpty) return [];

  final selected = ref.watch(selectedMonthProvider);
  if (selected == null) return []; // Should be populated by monthlySpending fallback

  final targetData = transactions.where((t) {
    return t.date.year == selected.year && 
           t.date.month == selected.month && 
           t.amount < 0;
  }).toList();

  // Group by category name
  final grouped = groupBy(targetData, (t) => t.category.name);
  
  return grouped.entries.map((entry) {
    final total = entry.value.fold<double>(0.0, (sum, t) => sum + t.amount.abs());
    final icon = entry.value.first.category.icon;
    return CategoryStat(entry.key, icon, total, entry.value.length);
  }).toList()..sort((a, b) => b.total.compareTo(a.total)); // Sort by total desc
}
