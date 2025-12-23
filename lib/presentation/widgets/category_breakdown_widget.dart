import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_wallet_lite/presentation/providers/category_stats_provider.dart';

class CategoryBreakdownWidget extends ConsumerWidget {
  const CategoryBreakdownWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statsAsync = ref.watch(categoryStatsProvider);

    // Show existing data immediately if available to prevent flickering
    if (statsAsync.hasValue) {
      return _buildBreakdown(context, statsAsync.value!);
    }

    return statsAsync.when(
      data: (stats) => _buildBreakdown(context, stats),
      loading: () => const SizedBox(
        height: 150, 
        child: Center(child: CircularProgressIndicator())
      ),
      error: (_, __) => const SizedBox.shrink(),
    );
  }

  Widget _buildBreakdown(BuildContext context, List<CategoryStat> stats) {
    final isEmpty = stats.isEmpty;
    final colorScheme = Theme.of(context).colorScheme;
    final total = stats.fold(0.0, (sum, stat) => sum + stat.total.abs());
    final colors = [
      colorScheme.primary,
      colorScheme.secondary,
      colorScheme.tertiary,
      Colors.orangeAccent,
      Colors.pinkAccent,
      Colors.cyanAccent,
      Colors.amberAccent,
    ];

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: colorScheme.onSurface.withValues(alpha: 0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Top Categories',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: colorScheme.onSurface),
              ),
              Icon(Icons.pie_chart, color: colorScheme.primary.withValues(alpha: 0.5)),
            ],
          ),
          const SizedBox(height: 30),
          if (isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 40),
              child: Center(
                child: Column(
                  children: [
                    Icon(Icons.category_outlined, size: 40, color: colorScheme.onSurface.withValues(alpha: 0.2)),
                    const SizedBox(height: 12),
                    Text(
                      'No category data available',
                      style: TextStyle(color: colorScheme.onSurface.withValues(alpha: 0.4), fontSize: 14),
                    ),
                  ],
                ),
              ),
            )
          else
            Row(
              children: [
                Expanded(
                  flex: 4,
                  child: SizedBox(
                    height: 180,
                    child: PieChart(
                      PieChartData(
                        sectionsSpace: 4,
                        centerSpaceRadius: 40,
                        sections: stats.take(5).indexed.map((item) {
                          final index = item.$1;
                          final stat = item.$2;
                          final color = colors[index % colors.length];
                          return PieChartSectionData(
                            color: color,
                            value: stat.total.abs(),
                            title: '${(stat.total.abs() / total * 100).toStringAsFixed(0)}%',
                            radius: 40,
                            titleStyle: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  flex: 6,
                  child: Column(
                    children: stats.take(5).indexed.map((item) {
                      final index = item.$1;
                      final stat = item.$2;
                      final color = colors[index % colors.length];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: color.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Icon(
                                _getCategoryIcon(stat.icon),
                                size: 14,
                                color: color,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                stat.category,
                                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: colorScheme.onSurface),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Text(
                              '\$${stat.total.abs().toStringAsFixed(0)}',
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: colorScheme.onSurface),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          const SizedBox(height: 24),
          const Divider(height: 1, thickness: 0.5),
          const SizedBox(height: 16),
          _buildTotalRow(context, 'Total Monthly Expenses', total),
        ],
      ),
    );
  }

  Widget _buildTotalRow(BuildContext context, String label, double amount) {
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(color: colorScheme.onSurface.withValues(alpha: 0.5), fontSize: 14),
        ),
        Text(
          '\$${amount.toStringAsFixed(2)}',
          style: TextStyle(
            color: colorScheme.error,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  IconData _getCategoryIcon(String iconName) {
    switch (iconName.toLowerCase()) {
      case 'shopping': return Icons.shopping_basket_outlined;
      case 'salary': return Icons.payments_outlined;
      case 'education': return Icons.school_outlined;
      case 'food': return Icons.restaurant_outlined;
      case 'fuel': return Icons.local_gas_station_outlined;
      case 'insurance': return Icons.security_outlined;
      case 'investment': return Icons.trending_up_outlined;
      case 'rent': return Icons.home_outlined;
      case 'bills': return Icons.receipt_long_outlined;
      case 'cash': return Icons.atm_outlined;
      case 'taxes': return Icons.account_balance_outlined;
      case 'fees': return Icons.info_outline;
      default: return Icons.category_outlined;
    }
  }
}
