import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loyalty_program_frontend/presentation/widgets/widgets.dart';

void main() {
  testWidgets('RewardStatus test', (widgetTester) async {
    double width = 360;
    double height = 800;
    double currentAmount = 3000;
    int currentMileStone = 4;
    int totalMileStone = 5;
    await widgetTester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: RewardStatus(
            width: width,
            height: height,
            currentAmount: currentAmount,
            currentAchievement: currentMileStone,
            totalMileStones: totalMileStone,
          ),
        ),
      ),
    );

    expect(find.text('Your Reward Points'), findsOneWidget);
    expect(find.text(currentAmount.toString()), findsOneWidget);
    expect(find.byType(Image), findsOneWidget);
  });
}
