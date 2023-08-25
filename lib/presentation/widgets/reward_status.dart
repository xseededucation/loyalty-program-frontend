import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:loyalty_program_frontend/domain/models/mile_stone.dart';
import 'package:loyalty_program_frontend/domain/models/page_information.dart';
import 'package:loyalty_program_frontend/presentation/utils/helpers/confetti_selector.dart';
import 'package:loyalty_program_frontend/presentation/utils/helpers/format_points.dart';
import 'package:loyalty_program_frontend/presentation/utils/helpers/size_helper.dart';

class RewardStatus extends StatelessWidget {
  final PageInformation? pageInformation;
  final double pointsToShow;
  final BoxConstraints boxConstraints;
  const RewardStatus({
    super.key,
    required this.boxConstraints,
    required this.pointsToShow,
    required this.pageInformation,
  });

  @override
  Widget build(BuildContext context) {
    List<MileStones> list = [];
    if (pageInformation?.conversionRates != null) {
      for (int i = 0; i < pageInformation!.conversionRates!.length; i++) {
        final MileStones obj = MileStones(
            credit: pageInformation?.conversionRates![i].credit!.toDouble(),
            denomination:
                pageInformation?.conversionRates![i].denomination!.toDouble(),
            sequenceNo: pageInformation?.conversionRates![i].sequenceNo,
            toolTipText: pageInformation?.conversionRates![i].toolTipText);
        list.add(obj);
      }
    }

    int? currentSliderPoint;
    void getPoints() {
      bool hasZero = false;
      for (int i = 0; i < list.length; i++) {
        if (list[i].credit == 0) {
          hasZero = true;
        }
      }
      if (!hasZero) {
        list.add(MileStones(
            credit: 0, denomination: 0, sequenceNo: 0, toolTipText: ""));
      }
      list.sort((a, b) => a.sequenceNo!.compareTo(b.sequenceNo!));
      for (int i = 0; i < list.length; i++) {
        if (pointsToShow >= list[i].credit!) {
          currentSliderPoint = i;
        }
      }
    }

    getPoints();
    Size sizeForMobile = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            image: currentSliderPoint != 0
                ? DecorationImage(
                    fit: BoxFit.fitHeight,
                    image: AssetImage(
                      'assets/images/confetti/${getConfettiBasedOnLevel(currentSliderPoint!, list.length)}',
                      package: 'loyalty_program_frontend',
                    ),
                  )
                : null,
          ),
          child: Column(
            children: [
              Text(
                'Your Reward Points',
                style: TextStyle(
                  fontSize: size(boxConstraints, 16),
                  fontWeight: FontWeight.w600,
                  color: const Color(0xffba181c),
                ),
              ),
              SizedBox(
                height: kIsWeb ? size(boxConstraints, 18) : 12,
              ),
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Container(
                  height: kIsWeb
                      ? size(boxConstraints, 180)
                      : sizeForMobile.width * 0.323,
                  width: kIsWeb
                      ? size(boxConstraints, 180)
                      : sizeForMobile.width * 0.323,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFFFFFFFF),
                        Color.fromRGBO(255, 252, 252, 0.94),
                        Color.fromRGBO(255, 241, 240, 0.66),
                        Color(0xFFfac8b2),
                      ],
                      stops: [0.0, 0.4167, 0.6615, 1.0],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 3,
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: kIsWeb ? size(boxConstraints, 38) : 20,
                      ),
                      SizedBox(
                        height: kIsWeb ? size(boxConstraints, 65) : 60,
                        width: size(boxConstraints, 65),
                        child: Image.asset(
                          'assets/images/coin.png',
                          package: 'loyalty_program_frontend',
                        ),
                      ),
                      SizedBox(height: kIsWeb ? size(boxConstraints, 15) : 8),
                      Text(
                        formatPoints(pointsToShow.toInt()),
                        style: TextStyle(
                          fontSize: kIsWeb ? size(boxConstraints, 20) : 20,
                          fontWeight: FontWeight.w900,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: size(boxConstraints, 30),
              )
            ],
          ),
        )
      ],
    );
  }
}
