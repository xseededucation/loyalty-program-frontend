import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:loyalty_program_frontend/presentation/utils/helpers/size_helper.dart';

class RewardRedeemButton extends StatelessWidget {
  final VoidCallback onPress;

  final BoxConstraints boxConstraints;
  const RewardRedeemButton(
      {super.key, required this.boxConstraints, required this.onPress});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: kIsWeb ? size(boxConstraints, 50) : 54,
        width: size(boxConstraints, 350),
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
          padding: EdgeInsets.only(
            left: size(boxConstraints, 10),
            right: size(boxConstraints, 10),
          ),
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
                          fontSize: size(boxConstraints, 16),
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      'Convert your earned points to a gift card',
                      overflow: TextOverflow.fade,
                      style: TextStyle(
                        fontSize: size(boxConstraints, 12),
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
