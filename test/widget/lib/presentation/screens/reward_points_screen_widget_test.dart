import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loyalty_program_frontend/presentation/screens/reward_points_screen.dart';
import 'package:loyalty_program_frontend/presentation/widgets/widgets.dart';

void main() {
  testWidgets('RewardPointScreen should render correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: SizedBox(
            width: 360,
            height: 600,
            child: RewardPointScreen(userDetail: {},),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle(const Duration(seconds: 3));
    if (!kIsWeb) {
      expect(find.text("Let's get started to earn rewards & much more!"),
          findsOneWidget);
      expect(find.byType(ProgressSlider), findsOneWidget);
      expect(find.byType(RewardStatus), findsOneWidget);
      expect(find.byType(RewardRedeemButton), findsOneWidget);
    }
  });
}
