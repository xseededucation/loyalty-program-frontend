import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loyalty_program_frontend/presentation/utils/external_packages/intl_wrapper.dart';
import 'package:loyalty_program_frontend/presentation/widgets/progress_bar.dart';

void main() {
  testWidgets(
    'ProgressSlider should display current status widget',
    ((WidgetTester tester) async {
      String name = 'pikachu';
      double amount = 200;
      final mileStone = [
        MileStone(amount: 100, message: 'hi'),
        MileStone(amount: 300, message: 'hello'),
        MileStone(amount: 400, message: 'bye')
      ];
      double width = 500;
      double value = 0;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ProgressSlider(
              currentAmount: amount,
              userName: name,
              mileStones: mileStone,
              width: width,
              onChange: (double value) {
                value = value;
              },
            ),
          ),
        ),
      );
      await tester.pumpAndSettle(const Duration(seconds: 3));
      expect(find.text('P'), findsOneWidget);
      expect(find.text('You are here'), findsOneWidget);
      expect(
          find.text(IntlWrapper.formatIndianCurrency(amount)), findsOneWidget);
      await tester.drag(find.byType(Slider), const Offset(300, 0));
      expect(
          find.text(IntlWrapper.formatIndianCurrency(value)), findsOneWidget);
    }),
  );

  testWidgets(
    'ProgressSlider should display current status widget',
    ((WidgetTester tester) async {
      String name = 'charizard';
      double amount = 500;
      final mileStone = [
        MileStone(amount: 100, message: 'hi'),
        MileStone(amount: 300, message: 'hello'),
        MileStone(amount: 500, message: 'bye')
      ];
      double width = 500;
      double value = 0;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ProgressSlider(
              currentAmount: amount,
              userName: name,
              mileStones: mileStone,
              width: width,
              onChange: (double value) {
                value = value;
              },
            ),
          ),
        ),
      );
      await tester.pumpAndSettle(const Duration(seconds: 3));
      expect(find.text('C'), findsOneWidget);
      expect(find.text('You are here'), findsOneWidget);
      expect(
          find.text(IntlWrapper.formatIndianCurrency(amount)), findsOneWidget);
      await tester.drag(find.byType(Slider), const Offset(300, 0));
      expect(
          find.text(IntlWrapper.formatIndianCurrency(value)), findsOneWidget);
    }),
  );
}
