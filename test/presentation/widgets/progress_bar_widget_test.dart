import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loyalty_program_frontend/domain/models/page_information.dart';
import 'package:loyalty_program_frontend/presentation/widgets/progress_bar.dart';

import '../../stubs/page_information_stub.dart';

void main() {
  testWidgets(
    'ProgressSlider should display current status widget',
    ((WidgetTester tester) async {
      String name = 'pikachu';
      double actualPoint = 300;
      double currentPoint = 300;
      String toolTipMessage = "Hello i am tooltip";
      List<ConversionRates> list =
          PageInformation.fromJson(data['data']).conversionRates!;
      double width = 500;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
              body: ProgressSlider(
            tooltipMessageZeroIndex: toolTipMessage,
            width: width,
            onChange: (double v) {},
            actualPoint: actualPoint,
            currentPoint: currentPoint,
            userName: name,
            conversionRates: list,
          )),
        ),
      );
      await tester.pumpAndSettle(const Duration(seconds: 3));
      expect(find.text('P'), findsOneWidget);
      expect(find.text('You are here'), findsOneWidget);
    }),
  );
}
