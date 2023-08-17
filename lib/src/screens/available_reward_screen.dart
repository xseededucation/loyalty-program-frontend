import 'package:flutter/material.dart';
import 'package:loyalty_program_frontend/src/widgets/reward_redeem_button.dart';
import 'package:loyalty_program_frontend/src/widgets/reward_status.dart';

class AvailableRewardPoint extends StatelessWidget {
  final double height;
  final double width;
  final String message;
  const AvailableRewardPoint(
      {super.key,
      required this.height,
      required this.width,
      required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
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
          SizedBox(
            height: height * 0.103,
          ),
          Text(
            message,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(
            height: height * 0.099,
          ),
          RewardStatus(
            width: width * 0.579,
            height: height,
            currentAchievement:
                1, //todo set this to index of passed milestone. it will be used to show proper confetti
            totalMileStones:
                2, // todo set this to total length of milestone excluding current and 0(zero)
            currentAmount:
                3000, // todo points that will be displayed in circular widget
          ),
          RewardRedeemButton(
            width: width * 0.579,
            height: height,
            onPress: () {
              //todo add goto redeem page logic here
            },
          ),
          SizedBox(
            height: height * 0.102,
          ),
        ],
      ),
    );
  }
}

String getConfettiBasedOnLevel(int indexOfMileStone, int lengthOfMileStone) {
  if (indexOfMileStone == 0) {
    return '';
  } else if (indexOfMileStone == lengthOfMileStone - 1) {
    return 'level_5.png';
  }

  int totalLevels = 3;
  int elementsPerLevel = ((lengthOfMileStone - 2) / totalLevels).ceil();

  if (indexOfMileStone < elementsPerLevel + 1) {
    return 'level_2.png';
  } else if (indexOfMileStone < 2 * elementsPerLevel + 1) {
    return 'level3_png';
  } else {
    return 'level_4.png';
  }
}
