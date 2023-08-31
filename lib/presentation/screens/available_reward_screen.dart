import 'package:flutter/material.dart';
import 'package:loyalty_program_frontend/domain/models/page_information.dart';
import 'package:loyalty_program_frontend/presentation/utils/helpers/has_user_achieved_any_milestone.dart';
import 'package:loyalty_program_frontend/presentation/utils/helpers/size_helper.dart';
import 'package:loyalty_program_frontend/presentation/widgets/reward_redeem_button.dart';
import 'package:loyalty_program_frontend/presentation/widgets/reward_status.dart';

class AvailableRewardPoint extends StatelessWidget {
  final VoidCallback onPress;
  final bool isHeaderMessageVisible;
  final BoxConstraints boxConstraints;
  final double currentAchievementLevel;
  final double originalPoint;
  final PageInformation? pageInformation;
  const AvailableRewardPoint(
      {super.key,
      required this.onPress,
      required this.boxConstraints,
      required this.currentAchievementLevel,
      required this.originalPoint,
      required this.pageInformation,
      this.isHeaderMessageVisible = true});

  @override
  Widget build(BuildContext context) {
    String? message;

    List<MileStonesAvailable> list = [];
    if (pageInformation?.conversionRates != null) {
      for (int i = 0; i < pageInformation!.conversionRates!.length; i++) {
        final MileStonesAvailable obj = MileStonesAvailable(
            message: pageInformation?.conversionRates![i].headerText,
            credit: pageInformation?.conversionRates![i].credit!.toDouble(),
            denomination:
                pageInformation?.conversionRates![i].denomination!.toDouble(),
            sequenceNo: pageInformation?.conversionRates![i].sequenceNo,
            toolTipText: pageInformation?.conversionRates![i].toolTipText);
        list.add(obj);
      }
    }
    void getMessage() {
      bool hasZero = false;
      for (int i = 0; i < list.length; i++) {
        if (list[i].credit == 0) {
          hasZero = true;
        }
      }
      if (!hasZero) {
        list.add(
          MileStonesAvailable(
            credit: 0,
            denomination: 0,
            sequenceNo: 0,
            toolTipText: "",
            message: pageInformation?.zeroCreditHeaderMessage,
          ),
        );
      }
      list.sort((a, b) => a.sequenceNo!.compareTo(b.sequenceNo!));
      if (originalPoint > list.last.credit!) {
        message = list.last.message;
        return;
      }
      for (int i = 0; i < list.length; i++) {
        if (originalPoint < list[i].credit!) {
          message = list[i - 1].message;
          break;
        } else if (originalPoint == list[i].credit!) {
          message = list[i].message;
          break;
        }
      }
    }

    getMessage();
    return SingleChildScrollView(
      child: Container(
        constraints: BoxConstraints(
          minHeight: size(
            boxConstraints,
            350,
          ),
        ),
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
            SizedBox(height: size(boxConstraints, 26)),
            if (isHeaderMessageVisible) ...{
              Text(
                message!,
                style: TextStyle(
                  fontSize: size(boxConstraints, 16),
                  fontWeight: FontWeight.w600,
                ),
              ),
            },
            SizedBox(height: size(boxConstraints, 24)),
            RewardStatus(
              boxConstraints: boxConstraints,
              pointsToShow: currentAchievementLevel,
              pageInformation: pageInformation,
            ),
            RewardRedeemButton(
              isActive: hasUserAchievedAnyMileStone(pageInformation!),
              boxConstraints: boxConstraints,
              onPress: onPress,
            ),
            SizedBox(height: size(boxConstraints, 54)),
          ],
        ),
      ),
    );
  }
}

class MileStonesAvailable {
  final double? credit;
  final double? denomination;
  final int? sequenceNo;
  final String? toolTipText;
  final String? message;

  MileStonesAvailable({
    required this.credit,
    required this.denomination,
    required this.sequenceNo,
    required this.toolTipText,
    required this.message,
  });
}
