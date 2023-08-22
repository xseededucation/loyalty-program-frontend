import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:loyalty_program_frontend/presentation/utils/helpers/size_helper.dart';
import 'package:loyalty_program_frontend/presentation/widgets/dailogs/sucess_dailog.dart';

class ConfirmationDailogBox extends StatelessWidget{
  final BoxConstraints constraints;
  final VoidCallback onConfirm;
  const ConfirmationDailogBox({super.key, required this.constraints,required this.onConfirm});
  
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
                  "Coupon Code",
                  style: TextStyle(
                      fontSize: size(constraints, 22),
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: size(constraints, 10),
                ),
                Image.asset(
                  'packages/loyalty_program_frontend/assets/images/coupon.png',
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
                          text: 'Coupon code worth ',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                            fontSize: kIsWeb
                                ? size(constraints, 18)
                                : size(constraints, 14),
                          ),
                        ),
                        TextSpan(
                          text: '₹1,000 ',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: kIsWeb
                                  ? size(constraints, 18)
                                  : size(constraints, 14),
                              fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: 'will be send to your registered email ID ',
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
                          text: '+91-9876567833.',
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
                        height: kIsWeb
                            ? size(constraints, 44)
                            : size(constraints, 34),
                        width: kIsWeb
                            ? size(constraints, 258)
                            : size(constraints, 120),
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
                              fontSize: size(constraints, 16)),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: size(constraints, 20),
                    ),
                    InkWell(
                      onTap: (){
                        onConfirm();
                      },
                      child: Container(
                        height: kIsWeb
                            ? size(constraints, 44)
                            : size(constraints, 34),
                        width: kIsWeb
                            ? size(constraints, 258)
                            : size(constraints, 120),
                        decoration: BoxDecoration(
                            color: const Color(0xffBA181C),
                            borderRadius: BorderRadius.circular(2)),
                        alignment: Alignment.center,
                        child: Text(
                          "Confirm",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                              fontSize: size(constraints, 16)),
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
  void _showSucessDialog(BuildContext context, BoxConstraints constraints) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SucessDailogBox(constraints: constraints);
      },
    );
  }
}