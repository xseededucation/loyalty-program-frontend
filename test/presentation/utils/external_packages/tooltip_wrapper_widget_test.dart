import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loyalty_program_frontend/presentation/utils/external_packages/tooltip_wrapper.dart';

void main() {
  testWidgets('TooltipWrapper test', (WidgetTester tester) async {
    ToolTipWrapper.initToolTipController();

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: ToolTipWrapper.getToolTip(
              child: const Text('Hover me'),
              message: 'This is a tooltip message',
            ),
          ),
        ),
      ),
    );
    expect(find.byType(Text), findsOneWidget);

    expect(find.text('This is a tooltip message'), findsNothing);

    ToolTipWrapper.showToolTip();
    await tester.pumpAndSettle(const Duration(seconds: 3));

    expect(find.text('This is a tooltip message'), findsOneWidget);

    ToolTipWrapper.hideToolTip();

    await tester.pumpAndSettle();

    expect(find.text('This is a tooltip message'), findsNothing);
    ToolTipWrapper.dispose();
  });
}
