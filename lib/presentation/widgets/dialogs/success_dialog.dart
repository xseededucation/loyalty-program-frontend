import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loyalty_program_frontend/loyalty_program_frontend.dart';
import 'package:loyalty_program_frontend/presentation/utils/constants/constant.dart';
import 'package:loyalty_program_frontend/presentation/utils/helpers/size_helper.dart';

class SuccessDialogBox extends StatelessWidget {
  const SuccessDialogBox({super.key});

  @override
  Widget build(BuildContext context) {
    BoxConstraints constraints = Constants.redeemRewardConstraints;
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
            Text(
              "Congratulations!",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 10),
            Image.asset(
              'packages/loyalty_program_frontend/assets/images/offer.png',
              width: kIsWeb ? 60 : 40,
              height: kIsWeb ? 60 : 40,
            ),
            SizedBox(height: kIsWeb ? 20 : 16),
            Padding(
              padding: EdgeInsets.only(
                  left: kIsWeb ? size(constraints, 28) : 0,
                  right: kIsWeb ? size(constraints, 10) : 0),
              child: RichText(
                text: TextSpan(
                  text: '',
                  style: DefaultTextStyle.of(context).style,
                  children: <TextSpan>[
                    TextSpan(
                      text:
                          'Your coupon code has been successfully sent to your ',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        fontSize: kIsWeb ? 18 : 14,
                      ),
                    ),
                    Constants.userData?.email.isNotEmpty
                        ? TextSpan(
                            text: 'registered email ID ',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                              fontSize: kIsWeb ? 18 : 14,
                            ),
                          )
                        : const TextSpan(),
                    Constants.userData?.email.isNotEmpty
                        ? TextSpan(
                            text: '${Constants.userData?.email ?? ""} ',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: kIsWeb ? 18 : 14,
                                fontWeight: FontWeight.bold),
                          )
                        : const TextSpan(),
                    Constants.userData?.mobileNumber.isNotEmpty
                        ? TextSpan(
                            text: 'and phone number ',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                              fontSize: kIsWeb ? 18 : 14,
                            ),
                          )
                        : const TextSpan(),
                    Constants.userData?.mobileNumber.isNotEmpty
                        ? TextSpan(
                            text:
                                '+${Constants.userData?.countryCode ?? ""} ${Constants.userData?.mobileNumber ?? ""}. ',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: kIsWeb ? 18 : 14,
                                fontWeight: FontWeight.bold),
                          )
                        : const TextSpan(),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: size(constraints, 30),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    BlocProvider.of<RewardPointsBloc>(context)
                        .add(FetchPageInformationEvent());
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: size(constraints, 44),
                    width: kIsWeb
                        ? size(constraints, 258)
                        : size(constraints, 200),
                    decoration: BoxDecoration(
                        color: const Color(0xffBA181C),
                        borderRadius: BorderRadius.circular(2)),
                    alignment: Alignment.center,
                    child: Text(
                      "OK",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                          fontSize: size(constraints, 18)),
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
