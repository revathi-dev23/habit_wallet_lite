import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/providers.dart';
import '../../domain/entities/transaction.dart' as domain;
import '../../domain/entities/category.dart' as domain_cat;
import '../widgets/sync_status_badge.dart';
import 'package:intl/intl.dart';

/// Example implementation showing how to display transactions with sync status
class TransactionListExample extends ConsumerWidget {
  const TransactionListExample({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transactionRepo = ref.watch(transactionRepositoryProvider);
    final syncStatus = ref.watch(syncStatusProvider);
    final pendingSyncCount = ref.watch(pendingSyncCountProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Transactions'),
        actions: [
          // Show pending sync count
          pendingSyncCount.when(
            data: (count) => count > 0
                ? Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Chip(
                      label: Text('$count pending'),
                      backgroundColor: Colors.orange.withValues(alpha: 0.2),
                    ),
                  )
                : const SizedBox.shrink(),
            loading: () => const SizedBox.shrink(),
            error: (_, __) => const SizedBox.shrink(),
          ),
          
          // Global sync indicator
          GlobalSyncIndicator(
            syncStatusNotifier: syncStatus,
            onTap: () {
              // Trigger manual sync
              ref.read(syncServiceProvider).syncAll();
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: transactionRepo.getTransactions(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData) {
            return const Center(child: Text('No transactions'));
          }

          final result = snapshot.data!;
          
          return result.when(
            success: (transactions) => _buildTransactionList(transactions),
            error: (failure) => Center(
              child: Text('Error: ${failure.message}'),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddTransaction(context, ref),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildTransactionList(List<domain.Transaction> transactions) {
    if (transactions.isEmpty) {
      return const Center(
        child: Text('No transactions yet.\nTap + to add one!'),
      );
    }

    return ListView.builder(
      itemCount: transactions.length,
      itemBuilder: (context, index) {
        final transaction = transactions[index];
        return TransactionListItem(transaction: transaction);
      },
    );
  }

  void _showAddTransaction(BuildContext context, WidgetRef ref) {
    // Implementation for adding transaction
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Add Transaction'),
        content: const Text('Implementation of add transaction form goes here'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              // Example add
              final repo = ref.read(transactionRepositoryProvider);
              final newTransaction = domain.Transaction(
                id: 'tx_${DateTime.now().millisecondsSinceEpoch}',
                amount: -100.0,
                category: const domain_cat.Category(
                  id: 'food',
                  name: 'Food',
                  icon: 'fastfood',
                ),
                date: DateTime.now(),
                note: 'Test transaction',
              );
              
              await repo.addTransaction(newTransaction);
              if (ctx.mounted) Navigator.pop(ctx);
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
}

/// Individual transaction list item with sync badge
class TransactionListItem extends StatelessWidget {
  final domain.Transaction transaction;

  const TransactionListItem({
    super.key,
    required this.transaction,
  });

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('MMM dd, yyyy');
    final currencyFormat = NumberFormat.currency(symbol: '₹');

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: transaction.amount >= 0
              ? Colors.green.withValues(alpha: 0.2)
              : Colors.red.withValues(alpha: 0.2),
          child: Icon(
            transaction.amount >= 0 ? Icons.arrow_downward : Icons.arrow_upward,
            color: transaction.amount >= 0 ? Colors.green : Colors.red,
          ),
        ),
        title: Row(
          children: [
            Expanded(
              child: Text(
                transaction.category.name,
                style: const TextStyle(fontWeight: FontWeight.bold),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            // Sync status badge
            SyncStatusBadge(
              isSynced: transaction.isSynced,
              editedLocally: transaction.editedLocally,
              compact: true,
            ),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (transaction.note.isNotEmpty)
              Text(
                transaction.note,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            const SizedBox(height: 4),
            Row(
              children: [
                Text(
                  dateFormat.format(transaction.date),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                if (!transaction.isSynced || transaction.editedLocally) ...[
                  const SizedBox(width: 8),
                  SyncStatusBadge(
                    isSynced: transaction.isSynced,
                    editedLocally: transaction.editedLocally,
                    compact: false,
                  ),
                ],
              ],
            ),
          ],
        ),
        trailing: Text(
          currencyFormat.format(transaction.amount.abs()),
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: transaction.amount >= 0 ? Colors.green : Colors.red,
          ),
        ),
        onTap: () {
          // Navigate to transaction detail
        },
      ),
    );
  }
}
