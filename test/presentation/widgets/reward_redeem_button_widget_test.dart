import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loyalty_program_frontend/presentation/widgets/widgets.dart';

void main() {
  testWidgets('RewardRedeemButton should render correctly',
      (WidgetTester tester) async {
    BoxConstraints constraints =
        const BoxConstraints(minHeight: 800, minWidth: 360);
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Center(
              child: RewardRedeemButton(
            boxConstraints: constraints,
            onPress: () {},
            isActive: false,
          )),
        ),
      ),
    );

    expect(find.text('Redeem Reward Points'), findsOneWidget);

    expect(
        find.text('Convert your earned points to a gift card'), findsOneWidget);
  });
}
