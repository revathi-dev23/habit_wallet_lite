import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_wallet_lite/domain/entities/transaction.dart';
import 'package:habit_wallet_lite/domain/entities/category.dart';
import 'package:habit_wallet_lite/presentation/pages/dashboard_screen.dart';
import 'package:habit_wallet_lite/presentation/providers/transaction_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MockTransactionList extends TransactionList {
  final AsyncValue<List<Transaction>> _state;
  MockTransactionList([this._state = const AsyncValue.loading()]);

  @override
  FutureOr<List<Transaction>> build() => _state.when(
    data: (d) => d,
    error: (e, s) => throw Exception(e.toString()),
    loading: () => Future.any([]), // Simulates loading
  );
}

void main() {
  testWidgets('DashboardScreen displays loading indicator initially', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          transactionListProvider.overrideWith(() => MockTransactionList()),
        ],
        child: const MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: DashboardScreen(),
        ),
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('DashboardScreen displays empty state when no transactions', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          transactionListProvider.overrideWith(() => MockTransactionList(const AsyncValue.data([]))),
        ],
        child: const MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: DashboardScreen(),
        ),
      ),
    );

    await tester.pumpAndSettle();
    expect(find.text('No transactions yet'), findsOneWidget);
  });

  testWidgets('DashboardScreen displays list of transactions', (WidgetTester tester) async {
    final testTransactions = [
      Transaction(
        id: '1',
        amount: -100.0,
        category: const Category(id: 'food', name: 'Food', icon: 'fastfood'),
        date: DateTime(2025, 12, 22),
        note: 'Lunch',
        isSynced: true,
      ),
    ];

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          transactionListProvider.overrideWith(() => MockTransactionList(AsyncValue.data(testTransactions))),
        ],
        child: const MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: DashboardScreen(),
        ),
      ),
    );

    await tester.pumpAndSettle();
    expect(find.text('Food'), findsOneWidget);
    expect(find.text('Lunch'), findsOneWidget);
  });

  testWidgets('DashboardScreen has FloatingActionButton for adding transaction', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          transactionListProvider.overrideWith(() => MockTransactionList(const AsyncValue.data([]))),
        ],
        child: const MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: DashboardScreen(),
        ),
      ),
    );

    await tester.pumpAndSettle();
    expect(find.byType(FloatingActionButton), findsOneWidget);
  });
}
