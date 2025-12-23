import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habit_wallet_lite/presentation/pages/pin_screen.dart';

void main() {
  testWidgets('PinScreen displays error on wrong pin', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: PinScreen()));

    // Tap '0' four times
    for (var i = 0; i < 4; i++) {
        await tester.tap(find.text('0'));
        await tester.pump();
    }

    expect(find.textContaining('Incorrect PIN'), findsOneWidget);
  });
}
