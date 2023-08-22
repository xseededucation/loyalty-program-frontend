import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:loyalty_program_frontend/presentation/utils/helpers/confetti_selector.dart';
import 'package:loyalty_program_frontend/presentation/utils/helpers/size_helper.dart';

class RewardStatus extends StatelessWidget {
  final int currentAchievement;
  final int totalMileStones;
  final double currentAmount;
  final BoxConstraints boxConstraints;
  const RewardStatus(
      {super.key,
      required this.boxConstraints,
      required this.currentAchievement,
      required this.totalMileStones,
      required this.currentAmount});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
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
                  fontSize: size(boxConstraints, 14),
                  fontWeight: FontWeight.w600,
                  color: Color(0xffba181c),
                ),
              ),
              SizedBox(height: size(boxConstraints, 30)),
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Container(
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
                        height: kIsWeb ? size(boxConstraints, 10) : 26,
                      ),
                      SizedBox(
                        height: kIsWeb
                            ? size(boxConstraints, 200)
                            : size(boxConstraints, 150),
                        width: size(boxConstraints, 200),
                        child: Image.asset(
                          'assets/images/coin.png',
                          package: 'loyalty_program_frontend',
                        ),
                      ),
                      SizedBox(height: kIsWeb ? size(boxConstraints, 10) : 8),
                      Text(
                        currentAmount.toString(),
                        style: TextStyle(
                          fontSize: kIsWeb ? size(boxConstraints, 20) : 20,
                          fontWeight: FontWeight.w900,
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
