import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loyalty_program_frontend/presentation/screens/available_reward_screen.dart';
import 'package:loyalty_program_frontend/presentation/widgets/widgets.dart';

void main() {
  testWidgets('AvailableRewardPoint widget displays correctly',
      (WidgetTester tester) async {
    bool isWorking = false;
    await tester.pumpWidget(
      MaterialApp(
          home: Scaffold(
        body: SizedBox(
          height: 1000,
          width: 1000,
          child: AvailableRewardPoint(
            boxConstraints: BoxConstraints(),
            message: 'Congratulations! You have earned a reward.',
            onPress: () {
              isWorking = true;
            },
          ),
        ),
      )),
    );

    expect(find.text('Congratulations! You have earned a reward.'),
        findsOneWidget);
    expect(find.byType(RewardStatus), findsOneWidget);
    expect(find.byType(RewardRedeemButton), findsOneWidget);
    await tester.tap(find.byType(RewardRedeemButton));
    expect(isWorking, true);
  });
}
