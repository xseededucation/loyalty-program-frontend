import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loyalty_program_frontend/presentation/utils/constants/constant.dart';
import 'package:loyalty_program_frontend/presentation/widgets/dialogs/confirmation_dialog.dart';
import 'package:mockito/mockito.dart';

abstract class IAppService {
  bool getkIsWeb();
}

class AppService implements IAppService {
  @override
  bool getkIsWeb() {
    return kIsWeb;
  }
}

class MockAppService extends Mock implements IAppService {}

class UserSample {
  final String email;
  final String mobileNumber;
  final String countryCode;

  UserSample(this.email, this.mobileNumber, this.countryCode);
}

void main() {
  AppService appService = AppService();
  dynamic data;
  data = UserSample('test@email.com', "9999999999", "+91");
  Constants.userData = data;
  testWidgets('ConfirmationDialogBox Test', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: Builder(
              builder: (BuildContext context) {
                return ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return ConfirmationDialogBox(
                          constraints: const BoxConstraints(
                              maxHeight: 500, maxWidth: 800),
                          denomination: '100',
                          onConfirm: () {
                            // Perform actions when "Confirm" is tapped.
                            // For example, you can use Navigator.pop(context);
                          },
                        );
                      },
                    );
                  },
                  child: const Text('Show Dialog'),
                );
              },
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.text('Show Dialog'));
    await tester.pumpAndSettle();

    expect(find.text('Coupon Code'), findsOneWidget);

    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();
  });

  testWidgets('ConfirmationDialogBox Test', (WidgetTester tester) async {
    if (appService.getkIsWeb()) {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: Builder(
                builder: (BuildContext context) {
                  return ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return ConfirmationDialogBox(
                            constraints: const BoxConstraints(
                                maxHeight: 500, maxWidth: 800),
                            denomination: '100',
                            onConfirm: () {
                              // Perform actions when "Confirm" is tapped.
                              // For example, you can use Navigator.pop(context);
                            },
                          );
                        },
                      );
                    },
                    child: const Text('Show Dialog'),
                  );
                },
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show Dialog'));
      await tester.pumpAndSettle();

      expect(find.text('Coupon Code'), findsOneWidget);

      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();
    }
  });
}
