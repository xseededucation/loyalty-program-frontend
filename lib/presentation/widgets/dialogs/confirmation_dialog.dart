import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:loyalty_program_frontend/presentation/utils/constants/constant.dart';
import 'package:loyalty_program_frontend/presentation/utils/helpers/size_helper.dart';

class ConfirmationDialogBox extends StatelessWidget {
  final BoxConstraints constraints;
  final String denomination;
  final VoidCallback onConfirm;
  const ConfirmationDialogBox(
      {super.key,
      required this.constraints,
      required this.onConfirm,
      required this.denomination});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(0)),
      ),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.3,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Coupon Code",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 10),
            Image.asset(
              'packages/loyalty_program_frontend/assets/images/coupon.png',
              width: kIsWeb ? 60 : 40,
              height: kIsWeb ? 60 : 40,
            ),
            SizedBox(height: kIsWeb ? 20 : 16),
            Padding(
              padding: EdgeInsets.only(
                left: kIsWeb ? size(constraints, 28) : 0,
                right: kIsWeb ? size(constraints, 10) : 0,
              ),
              child: RichText(
                text: TextSpan(
                  text: '',
                  style: DefaultTextStyle.of(context).style,
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Coupon code worth ',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                          fontSize: kIsWeb ? 18 : 14),
                    ),
                    TextSpan(
                      text: '₹${denomination} ',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: kIsWeb ? 18 : 14,
                          fontWeight: FontWeight.bold),
                    ),
                    Constants.userData?.email != null
                        ? TextSpan(
                            text: 'will be send to your registered email ID ',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                              fontSize: kIsWeb ? 18 : 14,
                            ),
                          )
                        : TextSpan(),
                    Constants.userData?.email.isNotEmpty
                        ? TextSpan(
                            text: '${Constants.userData?.email ?? ""} ',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: kIsWeb ? 18 : 14,
                                fontWeight: FontWeight.bold),
                          )
                        : TextSpan(),
                    Constants.userData?.mobileNumber.isNotEmpty
                        ? TextSpan(
                            text: 'and phone number ',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                              fontSize: kIsWeb ? 18 : 14,
                            ),
                          )
                        : TextSpan(),
                    Constants.userData?.mobileNumber.isNotEmpty
                        ? TextSpan(
                            text:
                                '+${Constants.userData?.countryCode ?? ""}  ${Constants.userData?.mobileNumber ?? ""}',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: kIsWeb ? 18 : 14,
                                fontWeight: FontWeight.bold),
                          )
                        : TextSpan(),
                  ],
                ),
              ),
            ),
            SizedBox(height: kIsWeb ? 30 : 26),
            if (kIsWeb)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 44,
                      width: 150,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                              color: const Color(0xffBA181C), width: 1.2),
                          borderRadius: BorderRadius.circular(2)),
                      alignment: Alignment.center,
                      child: Text(
                        "Cancel",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: const Color(0xffBA181C),
                            fontSize: 16),
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  InkWell(
                    onTap: () {
                      onConfirm();
                    },
                    child: Container(
                      height: 44,
                      width: 150,
                      decoration: BoxDecoration(
                          color: const Color(0xffBA181C),
                          borderRadius: BorderRadius.circular(2)),
                      alignment: Alignment.center,
                      child: Text(
                        "Confirm",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                            fontSize: 16),
                      ),
                    ),
                  ),
                ],
              )
            else
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      onConfirm();
                    },
                    child: Container(
                      height: 44,
                      width: 258,
                      decoration: BoxDecoration(
                          color: const Color(0xffBA181C),
                          borderRadius: BorderRadius.circular(2)),
                      alignment: Alignment.center,
                      child: const Text(
                        "Confirm",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                            fontSize: 16),
                      ),
                    ),
                  ),
                  SizedBox(height: size(constraints, 20)),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 44,
                      width: 258,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                              color: const Color(0xffBA181C), width: 1.2),
                          borderRadius: BorderRadius.circular(2)),
                      alignment: Alignment.center,
                      child: const Text(
                        "Cancel",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Color(0xffBA181C),
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              )
          ],
        ),
      ),
    );
  }
}
