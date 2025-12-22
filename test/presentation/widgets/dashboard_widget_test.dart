import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_wallet_lite/domain/entities/transaction.dart';
import 'package:habit_wallet_lite/domain/entities/category.dart';
import 'package:habit_wallet_lite/presentation/pages/dashboard_screen.dart';
import 'package:habit_wallet_lite/presentation/providers/transaction_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  testWidgets('DashboardScreen displays loading indicator initially', (WidgetTester tester) async {
    final container = ProviderContainer(
      overrides: [
        transactionListProvider.overrideWith((ref) => const AsyncValue.loading()),
      ],
    );

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: DashboardScreen(),
        ),
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    container.dispose();
  });

  testWidgets('DashboardScreen displays empty state when no transactions', (WidgetTester tester) async {
    final container = ProviderContainer(
      overrides: [
        transactionListProvider.overrideWith(
          (ref) => const AsyncValue.data(<Transaction>[]),
        ),
      ],
    );

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: DashboardScreen(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('No transactions yet'), findsOneWidget);

    container.dispose();
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
      Transaction(
        id: '2',
        amount: 5000.0,
        category: const Category(id: 'salary', name: 'Salary', icon: 'payment'),
        date: DateTime(2025, 12, 1),
        note: 'Monthly salary',
        isSynced: true,
      ),
    ];

    final container = ProviderContainer(
      overrides: [
        transactionListProvider.overrideWith(
          (ref) => AsyncValue.data(testTransactions),
        ),
      ],
    );

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: DashboardScreen(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.byType(ListTile), findsWidgets);
    expect(find.text('Food'), findsOneWidget);
    expect(find.text('Salary'), findsOneWidget);
    expect(find.text('Lunch'), findsOneWidget);
    expect(find.text('Monthly salary'), findsOneWidget);

    container.dispose();
  });

  testWidgets('DashboardScreen has FloatingActionButton for adding transaction', (WidgetTester tester) async {
    final container = ProviderContainer(
      overrides: [
        transactionListProvider.overrideWith(
          (ref) => const AsyncValue.data(<Transaction>[]),
        ),
      ],
    );

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: DashboardScreen(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.byType(FloatingActionButton), findsOneWidget);
    expect(find.byIcon(Icons.add), findsOneWidget);

    container.dispose();
  });

  testWidgets('DashboardScreen displays error message on error', (WidgetTester tester) async {
    final container = ProviderContainer(
      overrides: [
        transactionListProvider.overrideWith(
          (ref) => AsyncValue.error('Test error', StackTrace.current),
        ),
      ],
    );

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: DashboardScreen(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.textContaining('Error:'), findsOneWidget);

    container.dispose();
  });
}
