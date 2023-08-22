import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:loyalty_program_frontend/presentation/utils/helpers/confetti_selector.dart';
import 'package:loyalty_program_frontend/presentation/utils/helpers/format_points.dart';
import 'package:loyalty_program_frontend/presentation/utils/helpers/size_helper.dart';

class RewardStatus extends StatelessWidget {
  final int currentAchievement;
  final int totalMileStones;
  final double points;
  final BoxConstraints boxConstraints;
  const RewardStatus(
      {super.key,
      required this.boxConstraints,
      required this.currentAchievement,
      required this.totalMileStones,
      required this.points});

  @override
  Widget build(BuildContext context) {
    Size sizeForMobile = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            image: currentAchievement != 0
                ? DecorationImage(
                    fit: BoxFit.fitHeight,
                    image: AssetImage(
                      'assets/images/confetti/${getConfettiBasedOnLevel(currentAchievement, totalMileStones)}',
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
                        formatPoints(points.toInt()),
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
