import 'package:collection/collection.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'transaction_provider.dart';

part 'stats_provider.g.dart';

@riverpod
Future<Map<int, double>> monthlySpending(Ref ref) async {
  final transactions = await ref.watch(transactionListProvider.future);
  final now = DateTime.now();
  
  // Filter for current month
  final currentMonthTxns = transactions.where((t) {
    final tDate = t.date;
    return tDate.year == now.year && 
           tDate.month == now.month && 
           t.amount < 0; // Expenses only
  });

  // Group by day and sum amounts
  final grouped = groupBy(currentMonthTxns, (t) => t.date.day);
  
  return grouped.map((day, txns) {
    final sum = txns.fold<double>(0.0, (prev, t) => prev + t.amount.abs());
    return MapEntry(day, sum);
  });
}
