import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../domain/entities/transaction.dart';
import '../providers/transaction_provider.dart';
import '../widgets/monthly_chart_widget.dart';
import '../widgets/category_breakdown_widget.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transactionsAsync = ref.watch(transactionListProvider);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.appTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.sync),
            onPressed: () {
              // Trigger sync manually
              // ref.read(syncProvider).sync();
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => context.push('/settings'),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/add'),
        child: const Icon(Icons.add),
      ),
      body: transactionsAsync.when(
        data: (transactions) => _buildBody(context, transactions, l10n),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }

  Widget _buildBody(BuildContext context, List<Transaction> transactions, AppLocalizations l10n) {
    if (transactions.isEmpty) {
      return Center(child: Text(l10n.noTransactions));
    }

    return Column(
      children: [
        const MonthlyChartWidget(),
        const CategoryBreakdownWidget(),
        Expanded(
          child: ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (context, index) {
              final tx = transactions[index];
              return ListTile(
                leading: CircleAvatar(child: Text(tx.category.name[0])),
                title: Text(tx.category.name),
                subtitle: Text(tx.note),
                trailing: Text(
                  '${tx.amount}',
                  style: TextStyle(
                    color: tx.amount < 0 ? Colors.red : Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () => context.push('/tx/${tx.id}'),
              );
            },
          ),
        ),
      ],
    );
  }
}
