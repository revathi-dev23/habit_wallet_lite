import 'dart:async' show unawaited;
import 'package:collection/collection.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/transaction.dart';
import 'transaction_provider.dart';

part 'stats_provider.g.dart';

@riverpod
class SelectedMonth extends _$SelectedMonth {
  @override
  DateTime? build() => null; // Null means "auto-detect latest"

  void setMonth(DateTime month) => state = month;
}

class MonthlyStats {
  final Map<int, double> dailySpending;
  final DateTime targetMonth;
  final double totalIncome;
  final double totalExpenses;

  MonthlyStats(this.dailySpending, this.targetMonth, this.totalIncome, this.totalExpenses);
}

@riverpod
Future<MonthlyStats> monthlySpending(Ref ref) async {
  final transactions = await ref.watch(transactionListProvider.future);
  if (transactions.isEmpty) return MonthlyStats({}, DateTime.now(), 0, 0);

  final selected = ref.watch(selectedMonthProvider);
  DateTime targetMonth;
  
  if (selected != null) {
    targetMonth = DateTime(selected.year, selected.month);
  } else {
    // Default: show latest month with data
    final sortedByDate = transactions.toList()..sort((a, b) => b.date.compareTo(a.date));
    final latestDate = sortedByDate.first.date;
    targetMonth = DateTime(latestDate.year, latestDate.month);
    // Update selected month provider to the detected one if it was null
    unawaited(Future.microtask(() => ref.read(selectedMonthProvider.notifier).setMonth(targetMonth)));
  }

  final targetData = transactions.where((t) {
    return t.date.year == targetMonth.year && t.date.month == targetMonth.month;
  }).toList();

  // Calculate stats for target month
  final totalIncome = targetData.where((t) => t.amount > 0).fold(0.0, (sum, t) => sum + t.amount);
  final totalExpenses = targetData.where((t) => t.amount < 0).fold(0.0, (sum, t) => sum + t.amount.abs());

  // Group by day and sum amounts (for the chart - expenses only)
  final List<Transaction> expenseData = targetData.where((t) => t.amount < 0).toList();
  final Map<int, List<Transaction>> grouped = groupBy(expenseData, (Transaction t) => t.date.day);
  
  final dataMap = grouped.map<int, double>((int day, List<Transaction> txns) {
    final sum = txns.fold<double>(0.0, (prev, t) => prev + t.amount.abs());
    return MapEntry(day, sum);
  });

  return MonthlyStats(dataMap, targetMonth, totalIncome, totalExpenses);
}
