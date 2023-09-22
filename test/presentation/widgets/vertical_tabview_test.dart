import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loyalty_program_frontend/loyalty_program_frontend.dart';
import 'package:loyalty_program_frontend/presentation/widgets/vertical_tabview.dart';

import 'dialogs/success_dialog_test.dart';

void main() {
  testWidgets('VerticalTabView should build correctly',
      (WidgetTester tester) async {
    final fakeBloc = FakeRewardPointsBloc();

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: BlocProvider<RewardPointsBloc>(
            create: (context) => fakeBloc,
            child: const VerticalTabView(
              tabs: [
                Tab(text: 'Tab 1'),
                Tab(text: 'Tab 2'),
              ],
              contents: [
                Text('Content 1'),
                Text('Content 2'),
              ],
            ),
          ),
        ),
      ),
    );

    expect(find.text('Tab 1'), findsOneWidget);
    expect(find.text('Content 1'), findsOneWidget);

    await tester.tap(find.text('Tab 2'));
    await tester.pump();

    expect(find.text('Tab 2'), findsOneWidget);
    expect(find.text('Content 2'), findsOneWidget);
  });
}
