import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loyalty_program_frontend/loyalty_program_frontend.dart';
import 'package:loyalty_program_frontend/presentation/utils/helpers/size_helper.dart';
import 'package:loyalty_program_frontend/presentation/widgets/dailogs/confirmation_dailog.dart';
import 'package:loyalty_program_frontend/presentation/widgets/dailogs/sucess_dailog.dart';
import 'package:loyalty_program_frontend/presentation/widgets/loader.dart';

import '../utils/helpers/redeem_reward_utils.dart';

class RedeemRewardScreen extends StatefulWidget {
  const RedeemRewardScreen({super.key});

  @override
  State<RedeemRewardScreen> createState() => _RedeemRewardScreenState();
}

class _RedeemRewardScreenState extends State<RedeemRewardScreen> {
  TextEditingController currentCreditValue = TextEditingController(text: '0');
  int nearestCurrentCredit = 0;
  int currentPageIndex = 0;
  Map<String, dynamic> data = {
    "conversionRates": [],
    "products": [
      {
        "id": "64d1df1697a94657bcc091c7",
        "image":
            "https://xseed-public-static-assets.s3.us-west-2.amazonaws.com/loyalty-program/amazon_card.png"
      },
      {
        "id": "FakeProductWithFakeId",
        "image":
            "https://images.template.net/wp-content/uploads/2022/06/Coupon-Sizes1.jpg"
      }
    ],
    "currentCredit": 1000,
  };

  @override
  void initState() {
    super.initState();
  }

  List<Map<String, dynamic>> convertedList = [];

  // Triggered when plus button click
  onChangePointsIncrement(dynamic data) {
    if (int.parse(currentCreditValue.text) < nearestCurrentCredit) {
      int nextValue = RedeemRewardUtils.getNextCredit(
          convertedList, int.parse(currentCreditValue.text));
      setState(() {
        currentCreditValue.text = nextValue > nearestCurrentCredit
            ? nearestCurrentCredit.toString()
            : nextValue.toString();
      });
    }
  }

// Triggered when minus button click
  onChangePointsDecrement(dynamic data) {
    setState(() {
      currentCreditValue.text = RedeemRewardUtils.getPrevCredit(
              convertedList, int.parse(currentCreditValue.text))
          .toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(body: LayoutBuilder(
      builder: (context, constraints) {
        return BlocConsumer<RewardPointsBloc, RewardPointsState>(
          builder: (context, state) {
            if (state is RewardPointsSuccess) {
              if (convertedList.isEmpty) {
                convertedList =
                    state.pageInformation!.conversionRates!.map((rate) {
                  return {
                    "credit": rate.credit,
                    "denomination": rate.denomination
                  };
                }).toList();
                currentCreditValue.text =
                    state.pageInformation!.currentCredit.toString();
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  currentCreditValue.text =
                      RedeemRewardUtils.findNearestLastCredit(
                              convertedList, 3500)
                          .toString();
                  setState(() {
                    nearestCurrentCredit =
                        RedeemRewardUtils.findNearestLastCredit(
                            convertedList, 3500);
                  });
                });
              }
              int worthValue = RedeemRewardUtils.findDenomination(
                  convertedList, int.parse(currentCreditValue.text));
              return Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFFFFFFFF),
                      Color.fromRGBO(255, 252, 252, 0.94),
                      Color.fromRGBO(255, 241, 240, 0.66),
                      Color(0xFFFFF1F0),
                    ],
                    stops: [0.0, 0.4167, 0.6615, 1.0],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                          left: kIsWeb
                              ? size(constraints, 12)
                              : size(constraints, 12),
                          top: size(constraints, 12)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Redeem Reward Points",
                            style: TextStyle(
                                fontSize: kIsWeb
                                    ? size(constraints, 22)
                                    : size(constraints, 16),
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: size(constraints, 8),
                          ),
                          Row(
                            children: [
                              Text(
                                "Create a discount coupon and use it during checkout.",
                                style: TextStyle(
                                  fontSize: kIsWeb
                                      ? size(constraints, 18)
                                      : size(constraints, 14),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Image.asset(
                                'packages/loyalty_program_frontend/assets/images/gift_box.png',
                                width: size(constraints, 25),
                                height: size(constraints, 26),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: size(constraints, 50),
                        ),
                        SizedBox(
                          height: size(constraints, 200),
                          child: Stack(
                            children: [
                              PageView.builder(
                                itemCount: state.products?.length ?? 0,
                                scrollDirection: Axis.horizontal,
                                onPageChanged: (value) {
                                  setState(() {
                                    currentPageIndex = value;
                                  });
                                },
                                itemBuilder: (BuildContext context, int index) {
                                  return Center(
                                    child: Image.network(
                                      state.products?[currentPageIndex].url ??
                                          "",
                                      height: size(constraints, 237),
                                      width: size(constraints, 344),
                                      fit: BoxFit.contain,
                                    ),
                                  );
                                },
                              ),
                              Visibility(
                                visible: currentPageIndex != 0,
                                child: Align(
                                  alignment: kIsWeb
                                      ? Alignment.center
                                      : Alignment.centerLeft,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        right: kIsWeb
                                            ? size(constraints, 400)
                                            : 0),
                                    child: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            currentPageIndex--;
                                          });
                                        },
                                        icon: Icon(
                                          Icons.arrow_back_ios_outlined,
                                          size: size(constraints, 20),
                                        )),
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: state.products!.length > 1 &&
                                    currentPageIndex + 1 !=
                                        state.products!.length,
                                child: Align(
                                  alignment: kIsWeb
                                      ? Alignment.center
                                      : Alignment.centerRight,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: kIsWeb
                                            ? size(constraints, 400)
                                            : 0),
                                    child: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            currentPageIndex++;
                                          });
                                        },
                                        icon: Icon(
                                          Icons.arrow_forward_ios_outlined,
                                          size: size(constraints, 20),
                                        )),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: size(constraints, 10),
                        ),
                        SizedBox(
                          width: kIsWeb ? double.infinity : width * 0.8,
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              "Your points balance is ${currentCreditValue.text} worth of ₹$worthValue. How many points do you want to redeem?",
                              style: TextStyle(
                                fontSize: size(constraints, 16),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: size(constraints, 20)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              key: const Key('decrement'),
                              onTap: () {
                                onChangePointsDecrement(data);
                              },
                              child: Padding(
                                padding: EdgeInsets.only(
                                    bottom: size(constraints, 8)),
                                child: CircleAvatar(
                                  radius: size(constraints, 25),
                                  backgroundColor: Colors.black,
                                  child: Icon(
                                    Icons.remove,
                                    color: Colors.white,
                                    size: size(constraints, 25),
                                  ),
                                ),
                              ),
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  height: size(constraints, 50),
                                  width: size(constraints, 108),
                                  margin: EdgeInsets.symmetric(
                                    vertical: size(constraints, 5),
                                    horizontal: size(constraints, 20),
                                  ),
                                  padding: EdgeInsets.only(
                                      bottom: kIsWeb
                                          ? size(constraints, 15)
                                          : size(constraints, 8),
                                      left: size(constraints, 15),
                                      right: size(constraints, 5)),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5),
                                      border:
                                          Border.all(color: Color(0xffA5A5A5))),
                                  alignment: Alignment.center,
                                  child: SizedBox(
                                    width: size(constraints, 90),
                                    child: TextFormField(
                                      controller: currentCreditValue,
                                      enabled: false,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: size(constraints, 20),
                                          color: Colors.black),
                                      decoration: const InputDecoration(
                                          border: InputBorder.none),
                                    ),
                                  ),
                                ),
                                Text(
                                  "Worth of ₹${RedeemRewardUtils.findDenomination(convertedList, int.parse(currentCreditValue.text))}",
                                  style: TextStyle(
                                      color: const Color(0xff575757),
                                      fontSize: size(constraints, 16),
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                            InkWell(
                              key: const Key('increment'),
                              onTap: () {
                                onChangePointsIncrement(data);
                              },
                              child: Padding(
                                padding: EdgeInsets.only(
                                    bottom: size(constraints, 8)),
                                child: CircleAvatar(
                                  radius: size(constraints, 25),
                                  backgroundColor: Colors.black,
                                  child: Icon(
                                    Icons.add,
                                    color: Colors.white,
                                    size: size(constraints, 25),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: size(constraints, 18),
                        ),
                        InkWell(
                          onTap: () {
                            if (int.parse(currentCreditValue.text) > 300) {
                              _showConfirmationDialog(
                                  context, constraints, worthValue, () {
                                context.read<RewardPointsBloc>().add(
                                    TriggerPaymentEvent(
                                        int.parse(currentCreditValue.text),
                                        state.products![currentPageIndex].id!));
                              });
                            }
                          },
                          child: Container(
                            height: size(constraints, 64),
                            width: size(constraints, 436),
                            margin: EdgeInsets.symmetric(
                                horizontal: kIsWeb ? 0 : 10),
                            padding: EdgeInsets.only(
                                left: size(constraints, 11),
                                top: size(constraints, 11),
                                right: size(constraints, 11),
                                bottom: size(constraints, 11)),
                            decoration: BoxDecoration(
                                color: const Color(0xffFED945),
                                border:
                                    Border.all(color: const Color(0xffA5A5A5))),
                            alignment: Alignment.center,
                            child: Text(
                              "Redeem",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: kIsWeb
                                      ? size(constraints, 24)
                                      : size(constraints, 16),
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              );
            } else {
              return SizedBox();
            }
          },
          listener: (context, state) {
            if (state is RewardPointsSuccess) {
              if (state.message!.isNotEmpty) {
                _showSuccessDialog(context, constraints);
              }
            }
          },
        );
      },
    ));
  }

  void _showConfirmationDialog(BuildContext context, BoxConstraints constraints,
      int worthValue, VoidCallback onConfirm) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ConfirmationDialogBox(
          denomination: worthValue.toString(),
          constraints: constraints,
          onConfirm: () {
            Navigator.pop(context);
            onConfirm();
          },
        );
      },
    );
  }

  void _showSuccessDialog(BuildContext context, BoxConstraints constraints) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SuccessDialogBox(constraints: constraints);
      },
    );
  }
}
