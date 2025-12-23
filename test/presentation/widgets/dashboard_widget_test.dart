import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_wallet_lite/domain/entities/transaction.dart';
import 'package:habit_wallet_lite/domain/entities/category.dart';
import 'package:habit_wallet_lite/presentation/pages/dashboard_screen.dart';
import 'package:habit_wallet_lite/presentation/providers/transaction_provider.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:habit_wallet_lite/presentation/providers/connectivity_provider.dart';
import 'package:habit_wallet_lite/presentation/providers/stats_provider.dart';
import 'package:habit_wallet_lite/presentation/providers/category_stats_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MockTransactionList extends TransactionList {
  final AsyncValue<List<Transaction>> _state;
  MockTransactionList([this._state = const AsyncValue.loading()]);

  @override
  FutureOr<List<Transaction>> build() => _state.when(
    data: (d) => d,
    error: (e, s) => throw Exception(e.toString()),
    loading: () => Future.any([]), 
  );

  @override
  Future<void> syncData() async {}
}

void main() {
// ... tests ...

  testWidgets('DashboardScreen displays list of transactions', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(800, 2400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

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
          connectivityStatusProvider.overrideWith((ref) => Stream.value([ConnectivityResult.none])),
          monthlySpendingProvider.overrideWith((ref) => MonthlyStats({}, DateTime.now(), 0, 0)),
          categoryStatsProvider.overrideWith((ref) => <CategoryStat>[]),
        ],
        child: const MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: Locale('en'),
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
          connectivityStatusProvider.overrideWith((ref) => Stream.value([ConnectivityResult.none])),
          monthlySpendingProvider.overrideWith((ref) => MonthlyStats({}, DateTime.now(), 0, 0)),
          categoryStatsProvider.overrideWith((ref) => <CategoryStat>[]),
        ],
        child: const MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: Locale('en'),
          home: DashboardScreen(),
        ),
      ),
    );

    await tester.pumpAndSettle();
    expect(find.byType(FloatingActionButton), findsOneWidget);
  });
}
