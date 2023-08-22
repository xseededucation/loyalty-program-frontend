import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:loyalty_program_frontend/presentation/utils/helpers/size_helper.dart';

class SucessDailogBox extends StatelessWidget{
  final BoxConstraints constraints;
  const SucessDailogBox({super.key, required this.constraints});
  
  @override
  Widget build(BuildContext context) {
   return AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(0)),
          ),
          content: Container(
            width: size(constraints, 652),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Congratulations!",
                  style: TextStyle(
                      fontSize: size(constraints, 22),
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: size(constraints, 10),
                ),
                Image.asset(
                  'packages/loyalty_program_frontend/assets/images/offer.png',
                  width: size(constraints, 64),
                  height: size(constraints, 64),
                ),
                SizedBox(
                  height: size(constraints, 20),
                ),
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
                              'Your coupon code has been successfully sent to your registered email ID ',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                            fontSize: kIsWeb
                                ? size(constraints, 18)
                                : size(constraints, 14),
                          ),
                        ),
                        TextSpan(
                          text: 'ayushgupta@gmail.com ',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: kIsWeb
                                  ? size(constraints, 18)
                                  : size(constraints, 14),
                              fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: 'and phone number ',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                            fontSize: kIsWeb
                                ? size(constraints, 18)
                                : size(constraints, 14),
                          ),
                        ),
                        TextSpan(
                          text: '+91 9876567833.',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: kIsWeb
                                  ? size(constraints, 18)
                                  : size(constraints, 14),
                              fontWeight: FontWeight.bold),
                        ),
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
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: size(constraints, 44),
                        width: size(constraints, 258),
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