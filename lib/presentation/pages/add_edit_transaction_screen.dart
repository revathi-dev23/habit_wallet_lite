import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../domain/entities/transaction.dart';
import '../../domain/entities/category.dart';
import '../providers/transaction_provider.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

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
  List<String> _attachments = [];
  bool _isPickingFile = false;
  
  // Hardcoded categories for now, ideally fetch from repository
  final List<Category> _categories = const [
    Category(id: 'Food', name: 'Food', icon: 'fastfood'),
    Category(id: 'Travel', name: 'Travel', icon: 'flight'),
    Category(id: 'Bills', name: 'Bills', icon: 'receipt'),
    Category(id: 'Shopping', name: 'Shopping', icon: 'shopping_bag'),
    Category(id: 'Salary', name: 'Salary', icon: 'attach_money'),
    Category(id: 'Other', name: 'Other', icon: 'help'),
  ];

  bool _isExpense = true;

  @override
  void initState() {
    super.initState();
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
            _isExpense = tx.amount < 0;
            _attachments = List.from(tx.attachments);
          });
        });
      });
    } else {
      _selectedCategory = _categories.first;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.id == null ? l10n.addTransactionTitle : l10n.editTransactionTitle),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          children: [
            const SizedBox(height: 16),
            _buildTypeToggle(),
            const SizedBox(height: 32),
            _buildAmountInput(l10n),
            const SizedBox(height: 32),
            _buildCategoryLabel('Category'),
            const SizedBox(height: 12),
            _buildCategoryGrid(),
            const SizedBox(height: 32),
            _buildDatePicker(l10n),
            const SizedBox(height: 24),
            TextFormField(
              controller: _noteController,
              decoration: InputDecoration(
                labelText: l10n.note,
                prefixIcon: const Icon(Icons.note_alt_outlined),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
              ),
            ),
            const SizedBox(height: 24),
            _buildAttachmentStub(),
            const SizedBox(height: 48),
            ElevatedButton(
              onPressed: _submit,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 56),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              child: Text(l10n.save, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildTypeToggle() {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          _buildToggleItem(context, 'Expense', _isExpense, true),
          _buildToggleItem(context, 'Income', !_isExpense, false),
        ],
      ),
    );
  }

  Widget _buildToggleItem(BuildContext context, String label, bool isActive, bool isExpense) {
    final colorScheme = Theme.of(context).colorScheme;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _isExpense = isExpense),
        child: Semantics(
          label: label,
          selected: isActive,
          button: true,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: isActive ? colorScheme.surface : Colors.transparent,
              borderRadius: BorderRadius.circular(12),
              border: isActive ? Border.all(color: colorScheme.onSurface.withValues(alpha: 0.1)) : null,
            ),
            alignment: Alignment.center,
            child: Text(
              label,
              style: TextStyle(
                color: isActive ? (isExpense ? Colors.redAccent : colorScheme.primary) : colorScheme.onSurface.withValues(alpha: 0.3),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAmountInput(AppLocalizations l10n) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(l10n.amount, style: TextStyle(color: colorScheme.onSurface.withValues(alpha: 0.5))),
        const SizedBox(height: 8),
        IntrinsicWidth(
          child: TextFormField(
            controller: _amountController,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: colorScheme.onSurface),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(
              prefixText: '\$ ',
              prefixStyle: TextStyle(color: colorScheme.onSurface.withValues(alpha: 0.3)),
              border: InputBorder.none,
              hintText: '0.00',
              hintStyle: TextStyle(color: colorScheme.onSurface.withValues(alpha: 0.1)),
              helperText: 'Enter amount',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) return 'Required';
              if (double.tryParse(value) == null) return 'Invalid';
              return null;
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryLabel(String label) {
    return Text(label, style: TextStyle(color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5), fontSize: 13));
  }

  Widget _buildCategoryGrid() {
    final colorScheme = Theme.of(context).colorScheme;
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 1.2,
      ),
      itemCount: _categories.length,
      itemBuilder: (context, index) {
        final cat = _categories[index];
        final isSelected = _selectedCategory?.id == cat.id;
        return GestureDetector(
          onTap: () => setState(() => _selectedCategory = cat),
          child: Semantics(
            label: cat.name,
            selected: isSelected,
            button: true,
            child: Container(
              decoration: BoxDecoration(
                color: isSelected ? colorScheme.primary.withValues(alpha: 0.1) : colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isSelected ? colorScheme.primary : colorScheme.onSurface.withValues(alpha: 0.05),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    _getIconData(cat.icon),
                    color: isSelected ? colorScheme.primary : colorScheme.onSurface.withValues(alpha: 0.4),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    cat.name,
                    style: TextStyle(
                      fontSize: 12,
                      color: isSelected ? colorScheme.primary : colorScheme.onSurface.withValues(alpha: 0.4),
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  IconData _getIconData(String iconName) {
    switch (iconName) {
      case 'fastfood': return Icons.fastfood_outlined;
      case 'flight': return Icons.flight_outlined;
      case 'receipt': return Icons.receipt_long_outlined;
      case 'shopping_bag': return Icons.shopping_bag_outlined;
      case 'attach_money': return Icons.payments_outlined;
      default: return Icons.help_outline;
    }
  }

  Widget _buildAttachmentStub() {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Semantics(
          label: 'Add Attachment',
          button: true,
          child: GestureDetector(
            onTap: _isPickingFile ? null : _pickFiles,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: colorScheme.onSurface.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: colorScheme.onSurface.withValues(alpha: 0.1)),
              ),
              child: Row(
                children: [
                  Icon(Icons.attach_file, color: colorScheme.onSurface.withValues(alpha: 0.4)),
                  const SizedBox(width: 12),
                  Text(
                    _isPickingFile ? 'Picking...' : 'Add Attachment', 
                    style: TextStyle(color: colorScheme.onSurface.withValues(alpha: 0.4))
                  ),
                  const Spacer(),
                  if (_isPickingFile)
                    const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))
                  else
                    Icon(Icons.add_circle_outline, color: colorScheme.primary, size: 20),
                ],
              ),
            ),
          ),
        ),
        if (_attachments.isNotEmpty) ...[
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            children: _attachments.indexed.map((item) {
              final index = item.$1;
              final path = item.$2;
              final fileName = path.split(Platform.pathSeparator).last;
              return Chip(
                label: Text(fileName, style: const TextStyle(fontSize: 12)),
                onDeleted: () => setState(() => _attachments.removeAt(index)),
                deleteIcon: const Icon(Icons.close, size: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                backgroundColor: colorScheme.surfaceContainerHighest,
              );
            }).toList(),
          ),
        ],
      ],
    );
  }

  Future<void> _pickFiles() async {
    setState(() => _isPickingFile = true);
    try {
      final result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.any,
      );

      if (result != null) {
        setState(() {
          _attachments.addAll(result.paths.whereType<String>());
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error picking files: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isPickingFile = false);
    }
  }

  Widget _buildDatePicker(AppLocalizations l10n) {
    final colorScheme = Theme.of(context).colorScheme;
    return MergeSemantics(
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: Icon(Icons.calendar_today_outlined, color: colorScheme.onSurface.withValues(alpha: 0.4)),
        title: Text('Date', style: TextStyle(color: colorScheme.onSurface.withValues(alpha: 0.5), fontSize: 13)),
        subtitle: Text(
          '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
          style: TextStyle(color: colorScheme.onSurface, fontSize: 16),
        ),
        trailing: Icon(Icons.chevron_right, color: colorScheme.onSurface.withValues(alpha: 0.4)),
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
    );
  }

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      final baseAmount = double.parse(_amountController.text);
      final amount = _isExpense ? -baseAmount : baseAmount;
      final tx = Transaction(
        id: widget.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
        amount: amount,
        category: _selectedCategory!,
        date: _selectedDate,
        note: _noteController.text,
        attachments: _attachments,
      );

      if (widget.id == null) {
        await ref.read(transactionListProvider.notifier).addTransaction(tx);
      } else {
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
