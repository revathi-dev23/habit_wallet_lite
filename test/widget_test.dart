import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habit_wallet_lite/presentation/pages/pin_screen.dart';

// Mock Navigator logic if needed, but PinScreen navigation with GoRouter context.push is hard to mock without full App shell.

void main() {
  testWidgets('PinScreen displays error on wrong pin', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: PinScreen()));

    await tester.enterText(find.byType(TextField), '0000');
    // onChange triggers immediately in our code
    await tester.pump();

    expect(find.text('Incorrect PIN'), findsOneWidget);
  });
}
