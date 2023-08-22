import 'package:flutter/material.dart';
import 'package:loyalty_program_frontend/presentation/utils/helpers/size_helper.dart';
import 'package:loyalty_program_frontend/presentation/widgets/reward_redeem_button.dart';
import 'package:loyalty_program_frontend/presentation/widgets/reward_status.dart';

class AvailableRewardPoint extends StatelessWidget {
  final String message;
  final VoidCallback onPress;
  final BoxConstraints boxConstraints;
  const AvailableRewardPoint({
    super.key,
    required this.message,
    required this.onPress,
    required this.boxConstraints,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Container(
        constraints: BoxConstraints(minHeight: size(boxConstraints, 497)),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFFFFFFF),
              Color.fromRGBO(255, 252, 252, 0.94),
              Color.fromRGBO(255, 241, 240, 0.66),
              Color(0xFFFFF1F0),
            ],
            stops: [0.0, 0.4167, 0.6615, 1.0],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: size(boxConstraints, 40)),
            Text(
              message,
              style: TextStyle(
                fontSize: size(boxConstraints, 16),
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: size(boxConstraints, 30)),
            RewardStatus(
              boxConstraints: boxConstraints,
              currentAchievement:
                  1, //todo set this to index of passed milestone. it will be used to show proper confetti
              totalMileStones:
                  2, // todo set this to total length of milestone excluding current and 0(zero)
              points:
                  3000, // todo points that will be displayed in circular widget
            ),
            RewardRedeemButton(
              boxConstraints: boxConstraints,
              onPress: onPress,
            ),
            SizedBox(height: size(boxConstraints, 10)),
          ],
        ),
      ),
    );
  }
}
