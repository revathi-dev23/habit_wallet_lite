import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/transaction_provider.dart';

import 'package:go_router/go_router.dart';
import '../../domain/entities/transaction.dart';

class TransactionDetailScreen extends ConsumerWidget {
  final String id;
  const TransactionDetailScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listAsync = ref.watch(transactionListProvider);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transaction Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            tooltip: 'Edit Transaction',
            onPressed: () => context.push('/edit/$id'),
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
            tooltip: 'Delete Transaction',
            onPressed: () => _confirmDelete(context, ref),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Edit Transaction',
        onPressed: () => context.push('/edit/$id'),
        child: const Icon(Icons.edit_outlined),
      ),
      body: listAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('Error: $err')),
        data: (list) {
          final tx = list.firstWhere(
            (t) => t.id == id,
            orElse: () => throw Exception('Not Found'),
          );
          return _buildDetailBody(context, tx);
        },
      ),
    );
  }

  Widget _buildDetailBody(BuildContext context, Transaction tx) {
    final isExpense = tx.amount < 0;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              shape: BoxShape.circle,
            ),
            child: Icon(
              isExpense ? Icons.shopping_bag_outlined : Icons.payments_outlined,
              size: 48,
              color: isExpense ? Colors.redAccent : Theme.of(context).colorScheme.primary,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            tx.category.name,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal, color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7)),
          ),
          const SizedBox(height: 8),
          Text(
            '${isExpense ? "-" : "+"}\$${tx.amount.abs().toStringAsFixed(2)}',
            style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onSurface),
          ),
          const SizedBox(height: 32),
          _buildInfoRow(context, Icons.calendar_today_outlined, 'Date',
              '${tx.date.day}/${tx.date.month}/${tx.date.year}'),
          Divider(height: 32, color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.1)),
          _buildInfoRow(context, Icons.notes_outlined, 'Note', tx.note),
          Divider(height: 32, color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.1)),
          _buildInfoRow(context, Icons.sync_outlined, 'Status', _getStatusText(tx),
              trailing: _getStatusIcon(context, tx)),
          const SizedBox(height: 48),
          if (tx.editedLocally)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.orangeAccent.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.orangeAccent.withValues(alpha: 0.2)),
              ),
              child: const Row(
                children: [
                  Icon(Icons.info_outline, color: Colors.orangeAccent),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'This transaction has been edited locally and will be synced once online.',
                      style: TextStyle(color: Colors.orangeAccent, fontSize: 13),
                    ),
                  ),
                ],
              ),
            ),
          if (tx.attachments.isNotEmpty) ...[
            const SizedBox(height: 32),
            _buildAttachmentsSection(context, tx.attachments),
          ],
        ],
      ),
    );
  }

  Widget _buildAttachmentsSection(BuildContext context, List<String> paths) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.attachment, size: 20, color: colorScheme.onSurface.withValues(alpha: 0.4)),
            const SizedBox(width: 12),
            Text('Attachments (${paths.length})', 
                style: TextStyle(color: colorScheme.onSurface.withValues(alpha: 0.4), fontSize: 14)),
          ],
        ),
        const SizedBox(height: 12),
        ...paths.map((path) {
          final fileName = path.split(Platform.pathSeparator).last;
          return Container(
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(Icons.insert_drive_file_outlined, size: 20, color: colorScheme.primary),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(fileName, 
                      style: const TextStyle(fontSize: 14), 
                      maxLines: 1, 
                      overflow: TextOverflow.ellipsis),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }

  Widget _buildInfoRow(BuildContext context, IconData icon, String label, String value, {Widget? trailing}) {
    final colorScheme = Theme.of(context).colorScheme;
    return Semantics(
      label: '$label: $value',
      child: Row(
        children: [
          Icon(icon, size: 20, color: colorScheme.onSurface.withValues(alpha: 0.4)),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: TextStyle(color: colorScheme.onSurface.withValues(alpha: 0.4), fontSize: 12)),
              Text(value, style: TextStyle(color: colorScheme.onSurface, fontSize: 16, fontWeight: FontWeight.w500)),
            ],
          ),
          const Spacer(),
          if (trailing != null) trailing,
        ],
      ),
    );
  }

  String _getStatusText(Transaction tx) {
    if (tx.editedLocally) return 'Needs Sync';
    if (tx.isSynced) return 'Synced';
    return 'Pending';
  }

  Widget _getStatusIcon(BuildContext context, Transaction tx) {
    final colorScheme = Theme.of(context).colorScheme;
    if (tx.editedLocally) return const Icon(Icons.cloud_off, color: Colors.orangeAccent);
    if (tx.isSynced) return Icon(Icons.cloud_done, color: colorScheme.primary);
    return Icon(Icons.cloud_queue, color: colorScheme.onSurface.withValues(alpha: 0.4));
  }
  void _confirmDelete(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete Transaction?'),
        content: const Text('This action cannot be undone.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          TextButton(
            onPressed: () async {
              await ref.read(transactionListProvider.notifier).deleteTransaction(id);
              if (context.mounted) {
                Navigator.pop(ctx);
                context.pop();
              }
            },
            child: const Text('Delete', style: TextStyle(color: Colors.redAccent)),
          ),
        ],
      ),
    );
  }
}
