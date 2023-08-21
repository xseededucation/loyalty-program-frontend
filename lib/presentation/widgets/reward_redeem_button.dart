import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class RewardRedeemButton extends StatelessWidget {
  final double width;
  final double height;
  final VoidCallback onPress;
  const RewardRedeemButton(
      {super.key,
      required this.width,
      required this.height,
      required this.onPress});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: width * 0.835,
        height: kIsWeb ? height * .131 : 54,
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
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
          ),
          margin: const EdgeInsets.all(1),
          padding: EdgeInsets.only(left: width * 0.03, right: width * 0.03),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Redeem Reward Points',
                      overflow: TextOverflow.fade,
                      style: TextStyle(
                          fontSize: width * 0.04, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      'Convert your earned points to a gift card',
                      overflow: TextOverflow.fade,
                      style: TextStyle(
                        fontSize: width * .03,
                        color: const Color(0xff787F8C),
                      ),
                    ),
                  ],
                ),
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
