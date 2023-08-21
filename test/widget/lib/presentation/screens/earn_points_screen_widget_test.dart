import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loyalty_program_frontend/presentation/screens/earn_points_screen.dart';

void main() {
  testWidgets('EarnPointScreen Widget Test', (WidgetTester tester) async {
    const boxConstraints = BoxConstraints();

    await tester.pumpWidget(
      MaterialApp(
        home: EarnPointScreen(boxConstraints: boxConstraints),
      ),
    );

    // Verify that the initial UI elements are present
    expect(find.byType(Text), findsOneWidget);
    expect(find.byType(Image), findsNWidgets(2)); // 1 reward point coin image and 1 app image
    expect(find.byType(ListView), findsOneWidget);
    
    // Verify the presence of specific texts
    expect(find.text('Everytime you complete a lesson plan, you’ll earn more points.'), findsOneWidget);
    expect(find.text('Open SuperTeacher app & earn'), findsNWidgets(10));
    expect(find.text('Start using SuperTeacher app'), findsNWidgets(10));
    expect(find.text('+50'), findsNWidgets(10));

    // Verify the presence of specific images
    expect(find.image(AssetImage('packages/loyalty_program_frontend/assets/images/reward_point_coin.png')), findsOneWidget);
    // ... Add more assertions for image presence

    // Verify the separators
    expect(find.byType(Divider), findsNWidgets(9));
    // ... Add more assertions for separators

    // Scroll the ListView
    await tester.drag(find.byType(ListView), const Offset(0, -300));
    await tester.pumpAndSettle();

    // Verify the updated UI after scrolling
    // ... Add more assertions for the updated UI

    // Tap on an item in the ListView
    await tester.tap(find.text('Open SuperTeacher app & earn'));
    await tester.pump();

  });
}
