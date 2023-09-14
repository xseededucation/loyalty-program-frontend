import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loyalty_program_frontend/presentation/blocs/reward_points/reward_points_bloc.dart';
import 'package:loyalty_program_frontend/presentation/utils/constants/constant.dart';
import 'package:loyalty_program_frontend/presentation/widgets/dialogs/success_dialog.dart';

import 'confirmation_dialog_test.dart';

class FakeRewardPointsBloc extends Fake implements RewardPointsBloc {}

void main() {
  dynamic data;
  data = UserSample('test@email.com', "9999999999", "+91");
  Constants.userData = data;
  testWidgets('SuccessDialogBox should render correctly',
      (WidgetTester tester) async {
    final fakeBloc = FakeRewardPointsBloc();

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: BlocProvider<RewardPointsBloc>(
            create: (context) => fakeBloc,
            child: const SuccessDialogBox(),
          ),
        ),
      ),
    );

    expect(find.text("Congratulations!"), findsOneWidget);
  });
}
