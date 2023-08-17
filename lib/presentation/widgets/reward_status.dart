import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:loyalty_program_frontend/presentation/utils/helpers/confetti_selector.dart';

class RewardStatus extends StatelessWidget {
  final double width;
  final double height;
  final int currentAchievement;
  final int totalMileStones;
  final double currentAmount;
  const RewardStatus(
      {super.key,
      required this.width,
      required this.height,
      required this.currentAchievement,
      required this.totalMileStones,
      required this.currentAmount});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: kIsWeb ? height * 0.515 : 185,
          width: kIsWeb ? width * 0.579 : width,
          decoration: BoxDecoration(
              image: currentAchievement != 0
                  ? DecorationImage(
                      fit: BoxFit.fitHeight,
                      image: AssetImage(
                        'assets/images/confetti/${getConfettiBasedOnLevel(currentAchievement, totalMileStones)}',
                        package: 'loyalty_program_frontend',
                      ),
                    )
                  : null),
          child: Column(
            children: [
              const Text(
                'Your Reward Points',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Color(0xffba181c),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Container(
                width: width * 0.323,
                height: kIsWeb ? height * 0.387 : width * 0.323,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Container(
                  width: width * 0.323,
                  height: kIsWeb ? height * 0.387 : width * 0.323,
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
                        height: kIsWeb ? height * .096 : 26,
                      ),
                      SizedBox(
                        height: kIsWeb ? height * .136 : width * .112,
                        width: width * .112,
                        child: Image.asset(
                          'assets/images/coin.png',
                          package: 'loyalty_program_frontend',
                        ),
                      ),
                      const SizedBox(
                        height: kIsWeb ? 0 : 8,
                      ),
                      Text(
                        currentAmount.toString(),
                        style: TextStyle(
                          fontSize: kIsWeb ? width * .065 : 20,
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
