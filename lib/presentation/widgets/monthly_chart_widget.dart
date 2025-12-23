import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:habit_wallet_lite/presentation/providers/stats_provider.dart';

class MonthlyChartWidget extends ConsumerStatefulWidget {
  const MonthlyChartWidget({super.key});

  @override
  ConsumerState<MonthlyChartWidget> createState() => _MonthlyChartWidgetState();
}

class _MonthlyChartWidgetState extends ConsumerState<MonthlyChartWidget> {
  bool _isLineChart = false;

  @override
  Widget build(BuildContext context) {
    final statsAsync = ref.watch(monthlySpendingProvider);
    final selectedMonth = ref.watch(selectedMonthProvider);

    // If we have data (even if refreshing), show it immediately for zero-flicker
    if (statsAsync.hasValue) {
      return _buildChartContainer(context, statsAsync.value!, selectedMonth, statsAsync.isRefreshing);
    }

    return statsAsync.when(
      data: (stats) => _buildChartContainer(context, stats, selectedMonth, false),
      loading: () => const SizedBox(
        height: 200, 
        child: Center(child: CircularProgressIndicator())
      ),
      error: (_, __) => const SizedBox.shrink(),
    );
  }

  Widget _buildChartContainer(BuildContext context, MonthlyStats stats, DateTime? selectedMonth, bool isRefreshing) {
    final isEmpty = stats.dailySpending.isEmpty;
    final colorScheme = Theme.of(context).colorScheme;
    
    // Priority: 1. Selected Month (instant), 2. Target Month from Stats, 3. Now
    final displayMonth = selectedMonth ?? stats.targetMonth;
    final monthLabel = DateFormat('MMMM yyyy').format(displayMonth);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: colorScheme.onSurface.withValues(alpha: 0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Spending Trends',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: colorScheme.onSurface),
                  ),
                  Row(
                    children: [
                      _buildMonthNav(context, displayMonth, isNext: false),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Text(
                              monthLabel,
                              style: TextStyle(
                                fontSize: 13, 
                                fontWeight: FontWeight.w600,
                                color: isRefreshing ? colorScheme.primary.withValues(alpha: 0.5) : colorScheme.primary,
                              ),
                            ),
                            if (isRefreshing)
                              const SizedBox(
                                width: 12,
                                height: 12,
                                child: CircularProgressIndicator(strokeWidth: 2),
                              ),
                          ],
                        ),
                      ),
                      _buildMonthNav(context, displayMonth, isNext: true),
                    ],
                  ),
                ],
              ),
              if (!isEmpty)
                Container(
                  decoration: BoxDecoration(
                    color: colorScheme.surface,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: colorScheme.outlineVariant),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildToggleButton(Icons.bar_chart, !_isLineChart, () => setState(() => _isLineChart = false)),
                      _buildToggleButton(Icons.show_chart, _isLineChart, () => setState(() => _isLineChart = true)),
                    ],
                  ),
                ),
            ],
          ),
          const SizedBox(height: 30),
          if (isEmpty)
            SizedBox(
              height: 180,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.query_stats, size: 48, color: colorScheme.onSurface.withValues(alpha: 0.2)),
                    const SizedBox(height: 12),
                    Text(
                      'No spending recorded for this month',
                      style: TextStyle(color: colorScheme.onSurface.withValues(alpha: 0.4), fontSize: 14),
                    ),
                  ],
                ),
              ),
            )
          else
            AspectRatio(
              aspectRatio: 1.7,
              child: _isLineChart ? _buildLineChart(context, stats) : _buildBarChart(context, stats),
            ),
        ],
      ),
    );
  }

  Widget _buildToggleButton(IconData icon, bool isActive, VoidCallback onTap) {
    final colorScheme = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? colorScheme.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(
          icon,
          size: 18,
          color: isActive ? colorScheme.onPrimary : colorScheme.onSurface.withValues(alpha: 0.5),
        ),
      ),
    );
  }

  Widget _buildBarChart(BuildContext context, MonthlyStats stats) {
    final data = stats.dailySpending;
    final colorScheme = Theme.of(context).colorScheme;
    final maxDay = DateTime(stats.targetMonth.year, stats.targetMonth.month + 1, 0).day;
    
    final maxAmount = data.values.isEmpty ? 10.0 : data.values.reduce((a, b) => a > b ? a : b);

    return BarChart(
      BarChartData(
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          getDrawingHorizontalLine: (value) => FlLine(
            color: colorScheme.onSurface.withValues(alpha: 0.05),
            strokeWidth: 1,
          ),
        ),
        titlesData: _buildTitlesData(context, maxDay),
        borderData: FlBorderData(show: false),
        barGroups: List.generate(maxDay, (index) {
          final day = index + 1;
          final amount = (data[day] ?? 0.0).abs();
          return BarChartGroupData(
            x: day,
            barRods: [
              BarChartRodData(
                toY: amount,
                gradient: LinearGradient(
                  colors: [colorScheme.primary, colorScheme.primary.withValues(alpha: 0.6)],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
                width: 4,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
                backDrawRodData: BackgroundBarChartRodData(
                  show: true,
                  toY: maxAmount * 1.1,
                  color: colorScheme.onSurface.withValues(alpha: 0.03),
                ),
              )
            ],
          );
        }),
      ),
    );
  }

  Widget _buildLineChart(BuildContext context, MonthlyStats stats) {
    final data = stats.dailySpending;
    final colorScheme = Theme.of(context).colorScheme;
    final maxDay = DateTime(stats.targetMonth.year, stats.targetMonth.month + 1, 0).day;

    final spots = List.generate(maxDay, (index) {
      final day = index + 1;
      return FlSpot(day.toDouble(), (data[day] ?? 0.0).abs());
    });

    return LineChart(
      LineChartData(
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          getDrawingHorizontalLine: (value) => FlLine(
            color: colorScheme.onSurface.withValues(alpha: 0.05),
            strokeWidth: 1,
          ),
        ),
        titlesData: _buildTitlesData(context, maxDay),
        borderData: FlBorderData(show: false),
        lineBarsData: [
          LineChartBarData(
            spots: spots,
            isCurved: true,
            gradient: LinearGradient(colors: [colorScheme.primary, colorScheme.tertiary]),
            barWidth: 3,
            isStrokeCapRound: true,
            dotData: const FlDotData(show: false),
            belowBarData: BarAreaData(
              show: true,
              gradient: LinearGradient(
                colors: [
                  colorScheme.primary.withValues(alpha: 0.2),
                  colorScheme.primary.withValues(alpha: 0.0),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMonthNav(BuildContext context, DateTime current, {required bool isNext}) {
    final colorScheme = Theme.of(context).colorScheme;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          final newMonth = isNext 
            ? DateTime(current.year, current.month + 1)
            : DateTime(current.year, current.month - 1);
          ref.read(selectedMonthProvider.notifier).setMonth(newMonth);
        },
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Icon(
            isNext ? Icons.chevron_right : Icons.chevron_left,
            size: 20,
            color: colorScheme.primary,
          ),
        ),
      ),
    );
  }

  FlTitlesData _buildTitlesData(BuildContext context, int maxDay) {
    final colorScheme = Theme.of(context).colorScheme;
    return FlTitlesData(
      leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          getTitlesWidget: (value, meta) {
            if (value % 7 == 0 || value == 1 || value == maxDay) {
              return Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  value.toInt().toString(),
                  style: TextStyle(color: colorScheme.onSurface.withValues(alpha: 0.4), fontSize: 10),
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
