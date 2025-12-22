import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/stats_provider.dart';

class MonthlyChartWidget extends ConsumerWidget {
  const MonthlyChartWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statsAsync = ref.watch(monthlySpendingProvider);

    return statsAsync.when(
      data: (data) => _buildChart(context, data),
      loading: () => const SizedBox(height: 200, child: Center(child: CircularProgressIndicator())),
      error: (_, __) => const SizedBox.shrink(),
    );
  }

  Widget _buildChart(BuildContext context, Map<int, double> data) {
    if (data.isEmpty) return const SizedBox.shrink();

    final maxDay = DateTime(DateTime.now().year, DateTime.now().month + 1, 0).day;
    
    return AspectRatio(
      aspectRatio: 1.7,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BarChart(
          BarChartData(
            gridData: const FlGridData(show: false),
            titlesData: FlTitlesData(
              leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
              topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, meta) {
                     if (value % 5 == 0) {
                        return Text(value.toInt().toString(), style: const TextStyle(fontSize: 10));
                     }
                     return const SizedBox.shrink();
                  },
                ),
              ),
              rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            ),
            borderData: FlBorderData(show: false),
            barGroups: List.generate(maxDay, (index) {
              final day = index + 1;
              final amount = data[day] ?? 0.0;
              return BarChartGroupData(
                x: day,
                barRods: [
                  BarChartRodData(
                    toY: amount,
                    color: Theme.of(context).primaryColor,
                    width: 4,
                    borderRadius: BorderRadius.circular(2),
                  )
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
