import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loyalty_program_frontend/presentation/screens/redeem_reward_screen.dart';

void main() {
  testWidgets('RedeemRewardScreen should render', (WidgetTester tester) async {
    // Build our widget and trigger a frame.
    await tester.pumpWidget(MaterialApp(home: RedeemRewardScreen()));

    // Verify that the screen contains the expected text or widgets.
    expect(find.text("Redeem Reward Points"), findsOneWidget);
    expect(find.text("Create a discount coupon and use it during checkout."),
        findsOneWidget);

    // You can add more test cases here to validate other parts of the screen.
  });

  testWidgets('RedeemRewardScreen should change value when tapping increment',
      (WidgetTester tester) async {
    // Build our widget and trigger a frame.
    await tester.pumpWidget(MaterialApp(home: RedeemRewardScreen()));

    // Tap the increment button.
    await tester.tap(find.byKey(Key('increment')));
    await tester.pump();

    // Verify that the value has increased.
    expect(find.text('1'), findsOneWidget);
  });

  testWidgets('RedeemRewardScreen should change value when tapping decrement',
      (WidgetTester tester) async {
    // Build our widget and trigger a frame.
    await tester.pumpWidget(MaterialApp(home: RedeemRewardScreen()));

    // Tap the decrement button.
    await tester.tap(find.byKey(Key('decrement')));
    await tester.pump();

    // Verify that the value has decreased.
    expect(find.text('-1'), findsOneWidget);
  });
}
