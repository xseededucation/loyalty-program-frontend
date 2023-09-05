import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loyalty_program_frontend/domain/models/page_information.dart';
import 'package:loyalty_program_frontend/presentation/widgets/widgets.dart';

import '../../stubs/page_information_stub.dart';

void main() {
  testWidgets('RewardStatus test', (widgetTester) async {
    BoxConstraints constraints =
        const BoxConstraints(minHeight: 800, minWidth: 360);
    double pointToShow = 4000;

    await widgetTester.pumpWidget(
      MaterialApp(
        home: Scaffold(
            body: RewardStatus(
          boxConstraints: constraints,
          pointsToShow: pointToShow,
          pageInformation: PageInformation.fromJson(data['data']),
        )),
      ),
    );
    await widgetTester.pumpAndSettle();

    expect(find.byType(Image), findsOneWidget);
  });
}
