import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class TermsAndConditionDialogBox extends StatelessWidget {
  Function updateStatus;

  TermsAndConditionDialogBox({
    super.key,
    required this.updateStatus,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Center(
        child: Text(
          'STAR Program',
          style: TextStyle(
            color: Color(0xFFba181c),
            fontSize: kIsWeb ? 28 : 20,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
      content: ConstrainedBox(
        constraints: const BoxConstraints(
            maxHeight: kIsWeb ? 300.0 : 220, minWidth: 500.0),
        child: Center(
          child: Column(
            children: [
              const Text(
                'Become a Star 🌟',
                style: TextStyle(
                  fontSize: kIsWeb ? 18 : 14,
                  fontWeight: FontWeight.w600,
                  fontFamily: "Source Sans Pro",
                ),
              ),
              const SizedBox(height: 2),
              const Text(
                'Earn Rewards While You Teach!',
                style: TextStyle(
                  fontSize: kIsWeb ? 18 : 14,
                  fontWeight: FontWeight.w600,
                  fontFamily: "Source Sans Pro",
                ),
              ),
              const SizedBox(height: 6),
              Image.asset(
                'packages/loyalty_program_frontend/assets/images/terms_condition_coin.png',
                height: kIsWeb ? 200 : 130,
              ),
              // RichText(
              //   overflow: TextOverflow.clip,
              //   textAlign: TextAlign.end,
              //   textDirection: TextDirection.rtl,
              //   softWrap: true,
              //   maxLines: 1,
              //   textScaleFactor: 1,
              //   text: TextSpan(
              //     text: 'To start using our Star Program, please read our ',
              //     style: DefaultTextStyle.of(context).style.copyWith(
              //           fontSize: 12,
              //           fontWeight: FontWeight.w500,
              //           fontFamily: "Source Sans Pro",
              //         ),
              //     children: <TextSpan>[
              //       TextSpan(
              //         text: 'terms & Conditions, ',
              //         style: DefaultTextStyle.of(context).style.copyWith(
              //               fontSize: 12,
              //               fontWeight: FontWeight.w500,
              //               fontFamily: "Source Sans Pro",
              //               decoration: TextDecoration.underline,
              //             ),
              //         recognizer: TapGestureRecognizer()
              //           ..onTap = () {
              //             print('Link clicked!');
              //           },
              //       ),
              //     ],
              //   ),
              // ),
              Text.rich(
                textAlign: TextAlign.center,
                TextSpan(
                  children: [
                    const TextSpan(
                        text:
                            'To start using our Star Program, please read our ',
                        style: TextStyle(
                          fontSize: kIsWeb ? 16 : 12,
                          fontWeight: FontWeight.w500,
                          fontFamily: "Source Sans Pro",
                        )),
                    TextSpan(
                      text: 'Terms & Conditions, ',
                      style: const TextStyle(
                        fontSize: kIsWeb ? 16 : 12,
                        fontWeight: FontWeight.w500,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          print('Link clicked!');
                        },
                    ),
                    const TextSpan(
                      text: ' \nthen press Accept.!',
                      style: TextStyle(
                        fontSize: kIsWeb ? 16 : 12,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Source Sans Pro",
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        kIsWeb
            ? Container(
                padding: const EdgeInsets.only(bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OutlinedButton(
                      onPressed: () {
                        updateStatus("DECLINED");
                      },
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 70, vertical: 16),
                      ),
                      child: const Text(
                        'Decline',
                        style: TextStyle(
                          fontSize: kIsWeb ? 16 : 12,
                          fontWeight: FontWeight.w500,
                          fontFamily: "Source Sans Pro",
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: () {
                        updateStatus("ACCEPTED");
                      },
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 70, vertical: 16),
                      ),
                      child: const Text(
                        'Accept',
                        style: TextStyle(
                          fontSize: kIsWeb ? 16 : 12,
                          fontWeight: FontWeight.w500,
                          fontFamily: "Source Sans Pro",
                        ),
                      ),
                    )
                  ],
                ),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        updateStatus("ACCEPTED");
                      },
                      child: const Text(
                        'Accept',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          fontFamily: "Source Sans Pro",
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () {
                        updateStatus("DECLINED");
                      },
                      child: const Text(
                        'Decline',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          fontFamily: "Source Sans Pro",
                        ),
                      ),
                    ),
                  ),
                ],
              )
      ],
    );
  }
}
