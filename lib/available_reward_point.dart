import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:loyalty_program_frontend/widgets/progress_bar.dart';

class AvailableRewardPoints extends StatefulWidget {
  const AvailableRewardPoints({Key? key}) : super(key: key);

  @override
  State<AvailableRewardPoints> createState() => _AvailableRewardPointsState();
}

class _AvailableRewardPointsState extends State<AvailableRewardPoints> {
  String name = 'Ayush';
  List<MileStone> mileStones = [
    MileStone(message: 'winner winner chicken dinner', amount: 100),
    MileStone(message: 'winner winner chicken dinner', amount: 120),
    MileStone(message: 'winner winner chicken dinner', amount: 10000),
  ];
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        print(50 / constraints.maxHeight * 100);
        if (kIsWeb) {
          return Column(
            children: [
              Container(
                padding: const EdgeInsets.only(left: 37, right: 37, bottom: 22),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 0.5,
                    color: const Color(0xffcccdcd),
                  ),
                ),
                child: ProgressSlider(
                  currentAmount: 220,
                  mileStones: mileStones,
                  userName: 'Alok',
                  onChange: (v) {},
                  width: constraints.maxWidth,
                ),
              ),
              Container(
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
                  children: [],
                ),
              )
            ],
          );
        } else {
          return Container(
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 27),
                Text(
                  'Hi $name,',
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 6,
                ),
                const Text(
                  "Let's get started to earn rewards & much more!",
                  style: TextStyle(fontSize: 12),
                ),
                SizedBox(
                  height: 111,
                  child: ProgressSlider(
                      width: constraints.maxWidth,
                      currentAmount: 220,
                      mileStones: mileStones,
                      userName: 'Alok',
                      onChange: (v) {}),
                ),
                const SizedBox(
                  height: 17,
                ),
                _rewardStatus(
                  width: constraints.maxWidth,
                  currentAchievement: 5,
                  totalMileStones: 5,
                  currentAmount: 300,
                ),
                _redeemRewardPoint(width: constraints.maxWidth, onPress: () {})
              ],
            ),
          );
        }
      },
    );
  }

  Widget _rewardStatus(
      {required double width,
      required int currentAchievement,
      required int totalMileStones,
      required double currentAmount}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 185,
          width: width,
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
                height: width * 0.323,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Container(
                  width: width * 0.323,
                  height: width * 0.323,
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
                        height: width * 0.066,
                      ),
                      SizedBox(
                        height: width * .112,
                        width: width * .112,
                        child: Image.asset(
                          'assets/images/coin.png',
                          package: 'loyalty_program_frontend',
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        currentAmount.toString(),
                        style: const TextStyle(
                          fontSize: 20,
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

  Widget _redeemRewardPoint(
      {required double width, required VoidCallback onPress}) {
    return GestureDetector(
      onTap: onPress,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: width * 0.835,
        height: 54,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          gradient: const LinearGradient(
            colors: [
              Color(0xFFba181c),
              Color(0xFF2a4498),
            ],
            stops: [0.0, 1.0],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8), color: Colors.white),
          margin: const EdgeInsets.all(1),
          padding: const EdgeInsets.only(left: 22, right: 22),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'Redeem Reward Points',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    'Convert your earned points to a gift card',
                    style: TextStyle(
                      fontSize: 10,
                      color: Color(0xff787F8C),
                    ),
                  ),
                ],
              ),
              const Icon(
                size: 18,
                Icons.chevron_right,
                color: Color(0xff575757),
              )
            ],
          ),
        ),
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
