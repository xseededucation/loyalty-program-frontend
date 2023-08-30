import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:loyalty_program_frontend/presentation/utils/helpers/size_helper.dart';

class RewardRedeemButton extends StatelessWidget {
  final VoidCallback onPress;

  final BoxConstraints boxConstraints;
  final bool isActive;
  const RewardRedeemButton(
      {super.key,
      required this.boxConstraints,
      required this.onPress,
      this.isActive = true});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (isActive) {
          onPress();
        }
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: size(boxConstraints, kIsWeb ? 50 : 48),
        width: size(boxConstraints, kIsWeb ? 350 : 280),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: isActive ? null : const Color(0xffa6a6a6),
          gradient: isActive
              ? const LinearGradient(
                  colors: [
                    Color(0xFFba181c),
                    Color(0xFF2a4498),
                  ],
                  stops: [0.0, 1.0],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                )
              : null,
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: isActive ? Colors.white : const Color(0xfffefdfc),
          ),
          margin: const EdgeInsets.all(1),
          padding: EdgeInsets.only(
            left: size(boxConstraints, 12),
            right: size(boxConstraints, 12),
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
                        fontSize: size(boxConstraints, kIsWeb ? 16 : 14),
                        fontWeight: FontWeight.w500,
                        color: isActive ? null : const Color(0xffa6a6a6),
                      ),
                    ),
                    Text(
                      'Convert your earned points to a gift card',
                      overflow: TextOverflow.fade,
                      style: TextStyle(
                        fontSize: size(boxConstraints, kIsWeb ? 14 : 12),
                        color: isActive
                            ? const Color(0xff787F8C)
                            : const Color(0xffa6a6a6),
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                size: 18,
                Icons.chevron_right,
                color: isActive
                    ? const Color(0xff575757)
                    : const Color(0xffa6a6a6),
              )
            ],
          ),
        ),
      ),
    );
  }
}
