import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/category_stats_provider.dart';

class CategoryBreakdownWidget extends ConsumerWidget {
  const CategoryBreakdownWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statsAsync = ref.watch(categoryStatsProvider);

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
    if (stats.isEmpty) return const SizedBox.shrink();

    final total = stats.fold(0.0, (sum, stat) => sum + stat.total);

    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Category Breakdown',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 12),
            ...stats.take(5).map((stat) {
              final percentage = (stat.total / total * 100).toStringAsFixed(1);
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Text(stat.category),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        '₹${stat.total.toStringAsFixed(0)}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        '$percentage%',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
            if (stats.length > 5)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  '+ ${stats.length - 5} more categories',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
