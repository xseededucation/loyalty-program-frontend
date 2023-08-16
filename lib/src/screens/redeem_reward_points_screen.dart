import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:loyalty_program_frontend/src/utils/functions/get_date_description.dart';

class RedeemRewardPoints extends StatelessWidget {
  const RedeemRewardPoints({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    List<Map<String, dynamic>> tempData = [
      {"createdAt": "2023-08-15T08:28:32.711+00:00"},
      {"createdAt": "2023-08-11T08:28:32.711+00:00"},
      {"createdAt": "2023-08-11T08:28:32.711+00:00"},
      {"createdAt": "2023-07-31T13:39:14.916+00:00"},
      {"createdAt": "2022-07-31T13:39:14.916+00:00"},
    ];
    return Scaffold(
      backgroundColor: const Color(0xffFFEDEC),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Visibility(
            visible: kIsWeb,
            child: Padding(
              padding: EdgeInsets.only(top: 80.0),
              child: Text(
                "View your redeemed reward points.",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            constraints: BoxConstraints(
                maxHeight: kIsWeb ? height * 0.42 : height * 0.8,
                minHeight: height * 0.1),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(
                    tempData.length,
                    (index) => Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(
                              top: index > 0
                                  ? getDateDescription(tempData[index - 1]
                                              ['createdAt']) !=
                                          getDateDescription(
                                              tempData[index]['createdAt'])
                                      ? 10
                                      : 0
                                  : 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Visibility(
                                visible: index == 0 ||
                                    getDateDescription(
                                            tempData[index - 1]['createdAt']) !=
                                        getDateDescription(
                                            tempData[index]['createdAt']),
                                child: Container(
                                  padding: const EdgeInsets.only(
                                      left: 8, top: 11, right: 8, bottom: 11),
                                  width: 606,
                                  height: 35,
                                  color: const Color(0xffF5F7F9),
                                  child: Text(
                                    getDateDescription(
                                        tempData[index]['createdAt']),
                                    style: const TextStyle(
                                        color: Color(0xff8896B3),
                                        fontSize: 11,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                              Container(
                                  padding: const EdgeInsets.only(
                                      left: 8, top: 11, right: 8, bottom: 11),
                                  width: 606,
                                  color: Colors.white,
                                  child: Column(children: [
                                    Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: const [
                                                Text(
                                                  "Reward points redeemed",
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Color(0xff000000)),
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Icon(
                                                  Icons.circle,
                                                  size: 8,
                                                  color: Color(0xff7887A5),
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  "Not used",
                                                  style: TextStyle(
                                                      fontSize: 8,
                                                      color: Color(0xff575757)),
                                                ),
                                              ],
                                            ),
                                            const Text("You have redeemed ₹500",
                                                style: TextStyle(
                                                    fontSize: 11,
                                                    color: Color(0xff7887A5),
                                                    fontWeight:
                                                        FontWeight.w500))
                                          ],
                                        ),
                                        const Spacer(),
                                        Column(
                                          children: [
                                            Row(
                                              children:  [
                                               const Text(
                                                  "-3000",
                                                  style: TextStyle(
                                                      color: Color(0xffDC5F67),
                                                      fontSize: 11,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                               const SizedBox(
                                                  width: 2,
                                                ),                                                
                                                Image.asset("assets/images/coin_image.png")
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            InkWell(
                                              child: Container(
                                                alignment: Alignment.center,
                                                // height: 22,
                                                padding:
                                                    const EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4),
                                                    border: Border.all(
                                                        color: Colors.black)),
                                                child: const Text(
                                                  "Resend Code",
                                                  style: TextStyle(
                                                      fontSize: 11,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Colors.black),
                                                ),
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    const Divider(
                                      color: Color(0xffCCCDCD),
                                    )
                                  ])),
                            ],
                          ),
                        )),
              ),
            ),
          )
        ],
      ),
    );
  }
}
