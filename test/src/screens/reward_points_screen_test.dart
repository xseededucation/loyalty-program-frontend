import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loyalty_program_frontend/loyalty_program_frontend.dart';

void main() {
  testWidgets('RewardPointScreen should render correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: RewardPointScreen()));

    final teachEarnRewardedTextFinder =
        find.byKey(const Key('teachEarnRewardedText'));

    expect(teachEarnRewardedTextFinder, findsOneWidget);
  });
}
