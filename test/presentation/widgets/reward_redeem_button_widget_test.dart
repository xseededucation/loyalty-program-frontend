import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loyalty_program_frontend/presentation/widgets/widgets.dart';

void main() {
  testWidgets('RewardRedeemButton should render correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: RewardRedeemButton(
              width: 360,
              height: 325,
              onPress: () {},
            ),
          ),
        ),
      ),
    );

    expect(find.text('Redeem Reward Points'), findsOneWidget);

    expect(
        find.text('Convert your earned points to a gift card'), findsOneWidget);
  });

  testWidgets('RewardRedeemButton onTap callback should be triggered',
      (WidgetTester tester) async {
    bool callbackTriggered = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: RewardRedeemButton(
              width: 200,
              height: 60,
              onPress: () {
                callbackTriggered = true;
              },
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.byType(RewardRedeemButton));
    await tester.pump();

    expect(callbackTriggered, true);
  });
}
