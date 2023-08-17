import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:loyalty_program_frontend/presentation/utils/helpers/size_helper.dart';



class RedeemPointsScreen extends StatefulWidget {
  BoxConstraints boxConstraints;
  RedeemPointsScreen({super.key, required this.boxConstraints});

  @override
  State<RedeemPointsScreen> createState() => _RedeemPointsScreenState();
}

class _RedeemPointsScreenState extends State<RedeemPointsScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget redeemPointItemHeader() {
      return Container(
        padding: const EdgeInsets.all(10),
        color: const Color(0xffF5F7F9),
        width: MediaQuery.of(context).size.width,
        child: Text(
          'Yesterday',
          style: TextStyle(
            fontSize: size(widget.boxConstraints, 12),
            fontWeight: FontWeight.w600,
            fontFamily: "Source Sans Pro",
            color: const Color(0xff8896B3),
          ),
        ),
      );
    }

    return Container(
      padding: kIsWeb
          ? EdgeInsets.only(
              left: size(widget.boxConstraints, 50),
              right: size(widget.boxConstraints, 50),
              top: size(widget.boxConstraints, 40),
              bottom: size(widget.boxConstraints, 20),
            )
          : const EdgeInsets.all(0),
      color: const Color(0xffFFEDEC),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          if (kIsWeb) ...[
            Text(
              'View your redeemed reward points.',
              style: TextStyle(
                fontSize: size(widget.boxConstraints, 15),
                fontWeight: FontWeight.w600,
                fontFamily: "Source Sans Pro",
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20),
          ],
          Expanded(
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: 10,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    redeemPointItemHeader(),
                    Container(
                      color: Colors.white,
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Reward points redeemed',
                                    style: TextStyle(
                                      fontSize: size(widget.boxConstraints, 14),
                                      fontWeight: FontWeight.w600,
                                      fontFamily: "Source Sans Pro",
                                      color: Colors.black,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  const CircleAvatar(
                                    minRadius: 4,
                                    backgroundColor: Colors.black45,
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    'Not used',
                                    style: TextStyle(
                                        fontSize:
                                            size(widget.boxConstraints, 12),
                                        fontFamily: "Source Sans Pro",
                                        color: const Color(0xff575757),
                                        fontStyle: FontStyle.italic),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Text(
                                'You have redeemed ₹500',
                                style: TextStyle(
                                  fontSize: size(widget.boxConstraints, 12),
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "Source Sans Pro",
                                  color: const Color(0xff7887A5),
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    '-3000',
                                    style: TextStyle(
                                      fontSize: size(widget.boxConstraints, 14),
                                      fontWeight: FontWeight.w700,
                                      fontFamily: "Source Sans Pro",
                                      color: const Color(0xffDC5F67),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Image.asset(
                                    'packages/loyalty_program_frontend/assets/images/reward_point_coin.png',
                                    width: size(widget.boxConstraints, 24),
                                    height: size(widget.boxConstraints, 24),
                                  )
                                ],
                              ),
                              SizedBox(height: size(widget.boxConstraints, 10)),
                              SizedBox(
                                height: size(widget.boxConstraints, 32),
                                width: size(widget.boxConstraints, 96),
                                child: TextButton(
                                  onPressed: () {},
                                  style: ButtonStyle(
                                    padding: MaterialStateProperty.all(
                                        const EdgeInsets.all(2)),
                                    shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                        side: const BorderSide(
                                          color: Colors.black,
                                          width: 0.7,
                                        ),
                                        borderRadius: BorderRadius.circular(
                                          size(widget.boxConstraints, 6),
                                        ),
                                      ),
                                    ),
                                  ),
                                  child: Text(
                                    'Resend Code',
                                    style: TextStyle(
                                      fontFamily: "Source Sans Pro",
                                      color: Colors.black,
                                      fontSize: size(widget.boxConstraints, 14),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(height: 10);
              },
            ),
          ),
        ],
      ),
    );
  }
}
