import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/transaction_provider.dart';

import 'package:go_router/go_router.dart';

class TransactionDetailScreen extends ConsumerWidget {
  final String id;
  const TransactionDetailScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listAsync = ref.watch(transactionListProvider);
    
    return Scaffold(
      appBar: AppBar(title: const Text('Details')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/edit/$id'),
        child: const Icon(Icons.edit),
      ),
      body: listAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('Error: $err')),
        data: (list) {
          final tx = list.firstWhere(
            (t) => t.id == id,
            orElse: () => throw Exception('Not Found'),
          );
          return Padding(
             padding: const EdgeInsets.all(16.0),
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 Text(tx.category.name, style: Theme.of(context).textTheme.headlineMedium),
                 const SizedBox(height: 8),
                 Text('${tx.amount}', style: Theme.of(context).textTheme.displaySmall?.copyWith(
                   color: tx.amount < 0 ? Colors.red : Colors.green,
                 )),
                 const SizedBox(height: 16),
                 Text('Date: ${tx.date.toString()}'),
                 const SizedBox(height: 8),
                  Text('Note: ${tx.note}'),
                  const SizedBox(height: 8),
                  if (tx.editedLocally) 
                     const Chip(
                       label: Text('Edited Locally'), 
                       backgroundColor: Colors.orange,
                       avatar: Icon(Icons.edit, size: 16, color: Colors.white),
                     )
                  else if (tx.isSynced) 
                     const Chip(label: Text('Synced'), avatar: Icon(Icons.check, size: 16))
                  else
                     const Chip(label: Text('Not Synced'), backgroundColor: Colors.orangeAccent),
               ],
             ),
          );
        },
      ),
    );
  }
}
