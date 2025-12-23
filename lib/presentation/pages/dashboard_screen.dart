import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:habit_wallet_lite/domain/entities/transaction.dart';
import 'package:habit_wallet_lite/presentation/providers/transaction_provider.dart';
import 'package:habit_wallet_lite/presentation/providers/connectivity_provider.dart';
import 'package:habit_wallet_lite/presentation/providers/stats_provider.dart';
import 'package:habit_wallet_lite/presentation/widgets/monthly_chart_widget.dart';
import 'package:habit_wallet_lite/presentation/widgets/category_breakdown_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Start listening to connectivity for auto-sync
    ref.watch(connectivitySyncProvider);
    
    final transactionsAsync = ref.watch(transactionListProvider);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.appTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.sync),
            onPressed: () => ref.read(transactionListProvider.notifier).syncData(),
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => context.push('/settings'),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/add'),
        tooltip: l10n.addTransactionTitle,
        child: const Icon(Icons.add),
      ),
      body: transactionsAsync.when(
        data: (transactions) {
          final statsAsync = ref.watch(monthlySpendingProvider);
          final selectedMonth = ref.watch(selectedMonthProvider);
          final isSyncing = transactionsAsync.isRefreshing || statsAsync.isRefreshing;
          
          // Use current value or a default if loading for the first time
          final stats = statsAsync.valueOrNull ?? MonthlyStats({}, DateTime.now(), 0, 0);

          return Stack(
            children: [
              _buildBody(context, transactions, stats, selectedMonth, l10n),
              if (isSyncing)
                const Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: LinearProgressIndicator(minHeight: 2),
                ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }

  Widget _buildBody(BuildContext context, List<Transaction> transactions, MonthlyStats stats, DateTime? selectedMonth, AppLocalizations l10n) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: _buildBalanceCard(context, stats, selectedMonth),
          ),
        ),
        const SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: MonthlyChartWidget(),
          ),
        ),
        const SliverToBoxAdapter(
          child: CategoryBreakdownWidget(),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          sliver: SliverToBoxAdapter(
            child: Text(
              l10n.dashboardTitle,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
        ),
        if (transactions.isEmpty)
          SliverFillRemaining(
            child: Center(child: Text(l10n.noTransactions)),
          )
        else
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final tx = transactions[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                  child: _buildTransactionItem(context, tx),
                );
              },
              childCount: transactions.length,
            ),
          ),
        const SliverPadding(padding: EdgeInsets.only(bottom: 100)),
      ],
    );
  }

  Widget _buildBalanceCard(BuildContext context, MonthlyStats stats, DateTime? selectedMonth) {
    final totalSpent = stats.totalExpenses;
    final totalIncome = stats.totalIncome;
    final balance = totalIncome - totalSpent;
    final colorScheme = Theme.of(context).colorScheme;
    
    final displayMonth = selectedMonth ?? stats.targetMonth;

    return Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              colorScheme.primaryContainer,
              colorScheme.primaryContainer.withValues(alpha: 0.7),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${DateFormat('MMMM yyyy').format(displayMonth)} Balance',
                  style: TextStyle(color: colorScheme.onPrimaryContainer.withValues(alpha: 0.6), fontSize: 16),
                ),
                Icon(Icons.account_balance_wallet, color: colorScheme.primary),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              '\$${balance.toStringAsFixed(2)}',
              style: TextStyle(
                color: colorScheme.onPrimaryContainer,
                fontSize: 32,
                fontWeight: FontWeight.bold,
                letterSpacing: -1,
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(child: _buildInflowOutflow(context, 'Income', totalIncome, Icons.arrow_upward, Colors.greenAccent)),
                const SizedBox(width: 20),
                Expanded(child: _buildInflowOutflow(context, 'Expenses', totalSpent, Icons.arrow_downward, Colors.redAccent)),
              ],
            ),
          ],
        ),
      );
  }

  Widget _buildInflowOutflow(BuildContext context, String label, double amount, IconData icon, Color color) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 12, color: color),
            const SizedBox(width: 4),
            Text(label, style: TextStyle(color: colorScheme.onPrimaryContainer.withValues(alpha: 0.5), fontSize: 12)),
          ],
        ),
        Text(
          '\$${amount.toStringAsFixed(0)}',
          style: TextStyle(color: colorScheme.onPrimaryContainer, fontWeight: FontWeight.w600, fontSize: 16),
        ),
      ],
    );
  }

  Widget _buildTransactionItem(BuildContext context, Transaction tx) {
    final isExpense = tx.amount < 0;
    final colorScheme = Theme.of(context).colorScheme;
    return Semantics(
      label: 'Transaction: ${tx.category.name}, Note: ${tx.note}, Amount: ${isExpense ? "Expense" : "Income"} ${tx.amount.abs().toStringAsFixed(2)}',
      button: true,
      child: InkWell(
        onTap: () => context.push('/tx/${tx.id}'),
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).cardTheme.color,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: colorScheme.onSurface.withValues(alpha: 0.05)),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: isExpense ? Colors.redAccent.withValues(alpha: 0.1) : Colors.greenAccent.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Icon(
                  _getTransactionIcon(tx.category.icon, isExpense),
                  color: isExpense ? Colors.redAccent : Colors.greenAccent,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tx.category.name,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      tx.note,
                      style: TextStyle(color: colorScheme.onSurface.withValues(alpha: 0.5), fontSize: 13),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${isExpense ? "-" : "+"}\$${tx.amount.abs().toStringAsFixed(2)}',
                    style: TextStyle(
                      color: isExpense ? colorScheme.onSurface : colorScheme.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  if (!tx.isSynced)
                    const Icon(Icons.cloud_off, size: 12, color: Colors.orangeAccent),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getTransactionIcon(String iconName, bool isExpense) {
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
      default: return isExpense ? Icons.arrow_downward : Icons.arrow_upward;
    }
  }
}
