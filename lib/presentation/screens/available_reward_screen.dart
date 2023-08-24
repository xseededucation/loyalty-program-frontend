import 'package:flutter/material.dart';
import 'package:loyalty_program_frontend/domain/models/page_information.dart';
import 'package:loyalty_program_frontend/presentation/utils/helpers/size_helper.dart';
import 'package:loyalty_program_frontend/presentation/widgets/reward_redeem_button.dart';
import 'package:loyalty_program_frontend/presentation/widgets/reward_status.dart';

class AvailableRewardPoint extends StatelessWidget {
  final String message;
  final VoidCallback onPress;
  final BoxConstraints boxConstraints;
  final double currentAchievementLevel;
  final PageInformation pageInformation;
  const AvailableRewardPoint({
    super.key,
    required this.message,
    required this.onPress,
    required this.boxConstraints,
    required this.currentAchievementLevel,
    required this.pageInformation,
  });

  @override
  Widget build(BuildContext context) {
    PageInformation _pageInformation;
    _pageInformation = pageInformation;
    int? currentSliderPoint;
    void getPoints() {
      bool hasZero = false;
      for (int i = 0; i < _pageInformation.conversionRates!.length; i++) {
        if (_pageInformation.conversionRates![i].credit == 0) {
          hasZero = true;
        }
      }
      if (!hasZero) {
        _pageInformation.conversionRates!.add(ConversionRates(
            credit: 0, denomination: 0, sequenceNo: 0, toolTipText: ""));
      }
      _pageInformation.conversionRates!
          .sort((a, b) => a.sequenceNo!.compareTo(b.sequenceNo!));
      for (int i = 0; i < _pageInformation.conversionRates!.length; i++) {
        if (currentAchievementLevel >=
            _pageInformation.conversionRates![i].credit!) {
          currentSliderPoint = i;
        }
      }
    }

    getPoints();

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
              currentAchievement: currentSliderPoint!,
              totalMileStones: _pageInformation.conversionRates!.length,
              points: currentAchievementLevel,
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
