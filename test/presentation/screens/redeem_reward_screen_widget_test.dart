import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loyalty_program_frontend/presentation/screens/redeem_reward_screen.dart';

void main() {
  testWidgets('Test Redeem Reward Points Widgets', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
      home: RedeemRewardScreen(),
    ));      

    expect(find.text('Redeem Reward Points'), findsOneWidget);
    expect(find.text('Create a discount coupon and use it during checkout.'), findsOneWidget);
    expect(find.byIcon(Icons.remove), findsOneWidget);
    expect(find.byIcon(Icons.add), findsOneWidget);
    expect(find.byKey(const Key('decrement')), findsOneWidget);
    expect(find.byKey(const Key('increment')), findsOneWidget);
    expect(find.text('Redeem'), findsOneWidget);

    // Perform tap on buttons
    await tester.tap(find.byKey(const Key('increment')));
    await tester.pump();


    await tester.tap(find.byKey(const Key('decrement')));
    await tester.pump();


    // Perform tap on Redeem button
    await tester.tap(find.text('Redeem'));
    await tester.pump();
    // Verify the confirmation dialog shows up
    expect(find.text('Coupon Code'), findsOneWidget);    

    // Dismiss the dialog
    await tester.tap(find.text('Cancel'));
    await tester.pump();

    // Perform another tap on Redeem button
    await tester.tap(find.text('Redeem'));
    await tester.pump();

    // Confirm the redemption
    await tester.tap(find.text('Confirm'));
    await tester.pump();

    // Verify the success dialog shows up
    expect(find.text('Congratulations!'), findsOneWidget);    

    // Perform tap to close success dialog
    await tester.tap(find.text('OK'));
    await tester.pump();

  });
}
