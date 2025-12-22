import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../domain/entities/transaction.dart';
import '../../domain/entities/category.dart';
import '../providers/transaction_provider.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddEditTransactionScreen extends ConsumerStatefulWidget {
  final String? id; // If null, it's Add mode
  const AddEditTransactionScreen({super.key, this.id});

  @override
  ConsumerState<AddEditTransactionScreen> createState() => _AddEditTransactionScreenState();
}

class _AddEditTransactionScreenState extends ConsumerState<AddEditTransactionScreen> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _noteController = TextEditingController();
  Category? _selectedCategory;
  DateTime _selectedDate = DateTime.now();
  
  // Hardcoded categories for now, ideally fetch from repository
  final List<Category> _categories = const [
    Category(id: 'Food', name: 'Food', icon: 'fastfood'),
    Category(id: 'Travel', name: 'Travel', icon: 'flight'),
    Category(id: 'Bills', name: 'Bills', icon: 'receipt'),
    Category(id: 'Shopping', name: 'Shopping', icon: 'shopping_bag'),
    Category(id: 'Salary', name: 'Salary', icon: 'attach_money'),
    Category(id: 'Other', name: 'Other', icon: 'help'),
  ];

  @override
  void initState() {
    super.initState();
    // Load existing transaction if in edit mode
    if (widget.id != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final transactionsAsync = ref.read(transactionListProvider);
        transactionsAsync.whenData((transactions) {
          final tx = transactions.firstWhere((t) => t.id == widget.id);
          setState(() {
            _amountController.text = tx.amount.abs().toString();
            _noteController.text = tx.note;
            _selectedCategory = _categories.firstWhere(
              (c) => c.name == tx.category.name,
              orElse: () => _categories.last,
            );
            _selectedDate = tx.date;
          });
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.id == null ? l10n.addTransactionTitle : l10n.editTransactionTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _amountController,
                decoration: InputDecoration(labelText: l10n.amount),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Required'; // Simple validation
                  if (double.tryParse(value) == null) return 'Invalid number';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<Category>(
                value: _selectedCategory,
                items: _categories.map((c) {
                  return DropdownMenuItem(value: c, child: Text(c.name));
                }).toList(),
                onChanged: (val) => setState(() => _selectedCategory = val),
                 decoration: InputDecoration(labelText: l10n.category),
                 validator: (val) => val == null ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              ListTile(
                title: Text('${l10n.date}: ${_selectedDate.toLocal().toString().split(' ')[0]}'),
                trailing: const Icon(Icons.calendar_today),
                onTap: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: _selectedDate,
                    firstDate: DateTime(2020),
                    lastDate: DateTime.now(),
                  );
                  if (picked != null) setState(() => _selectedDate = picked);
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _noteController,
                decoration: InputDecoration(labelText: l10n.note),
              ),
              const SizedBox(height: 16),
              // Attachment Stub
              ListTile(
                leading: const Icon(Icons.attach_file),
                title: Text('${l10n.attachment} (${l10n.pickFile})'),
                onTap: () {
                   ScaffoldMessenger.of(context).showSnackBar(
                     const SnackBar(content: Text('File Picker stub')),
                   );
                },
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _submit,
                child: Text(l10n.save),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      final amount = double.parse(_amountController.text);
      final tx = Transaction(
        id: widget.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
        amount: amount, // Logic for income/expense could be added
        category: _selectedCategory!,
        date: _selectedDate,
        note: _noteController.text,
      );

      if (widget.id == null) {
        // Add mode
        await ref.read(transactionListProvider.notifier).addTransaction(tx);
      } else {
        // Edit mode
        await ref.read(transactionListProvider.notifier).updateTransaction(tx);
      }
      
      if (mounted) context.pop();
    }
  }

  @override
  void dispose() {
    _amountController.dispose();
    _noteController.dispose();
    super.dispose();
  }
}
