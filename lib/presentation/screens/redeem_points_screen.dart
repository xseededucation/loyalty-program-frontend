import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loyalty_program_frontend/domain/models/page_information.dart';
import 'package:loyalty_program_frontend/presentation/blocs/reward_points/reward_points_bloc.dart';
import 'package:loyalty_program_frontend/presentation/blocs/reward_points/reward_points_event.dart';
import 'package:loyalty_program_frontend/presentation/blocs/reward_points/reward_points_state.dart';
import 'package:loyalty_program_frontend/presentation/utils/helpers/size_helper.dart';
import 'package:loyalty_program_frontend/presentation/widgets/reward_redeem_button.dart';
import 'package:loyalty_program_frontend/presentation/widgets/widgets.dart';

class RedeemPointsScreen extends StatefulWidget {
  final BoxConstraints boxConstraints;
  const RedeemPointsScreen({super.key, required this.boxConstraints});

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
    Widget redeemPointItemHeader(String text) {
      return Container(
        padding: const EdgeInsets.all(10),
        color: const Color(0xffF5F7F9),
        width: MediaQuery.of(context).size.width,
        child: Text(
          '$text',
          style: TextStyle(
            fontSize: kIsWeb ? 16 : 14,
            fontWeight: FontWeight.w600,
            fontFamily: "Source Sans Pro",
            color: const Color(0xff8896B3),
          ),
        ),
      );
    }

    Widget redeemPointItemBody(List<dynamic> transactions, int index) {
      Transaction transaction = transactions[index] as Transaction;

      return Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Row(
                //   children: [
                //     Text(
                //       'Reward points redeemed',
                //       style: TextStyle(
                //         fontSize: size(widget.boxConstraints, 14),
                //         fontWeight: FontWeight.w600,
                //         fontFamily: "Source Sans Pro",
                //         color: Colors.black,
                //       ),
                //     ),
                //     const SizedBox(width: 10),
                //     const CircleAvatar(
                //       minRadius: 4,
                //       backgroundColor: Colors.black45,
                //     ),
                //     const SizedBox(width: 10),
                //     Text(
                //       'Not used',
                //       style: TextStyle(
                //           fontSize: size(widget.boxConstraints, 12),
                //           fontFamily: "Source Sans Pro",
                //           color: const Color(0xff575757),
                //           fontStyle: FontStyle.italic),
                //     ),
                //   ],
                // ),
                Text(
                  'Reward points redeemed',
                  style: TextStyle(
                    fontSize: kIsWeb ? 16 : 14,
                    fontWeight: kIsWeb ? FontWeight.w600 : FontWeight.w500,
                    fontFamily: "Source Sans Pro",
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: kIsWeb ? 10 : 6),
                Text(
                  'You have redeemed ₹${transaction.denomination}',
                  style: TextStyle(
                    fontSize: kIsWeb ? 14 : 12,
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
                    Container(
                      margin: const EdgeInsets.only(top: 6),
                      child: Text(
                        '- ${transaction.credit}',
                        style: TextStyle(
                          fontSize: kIsWeb ? 16 : 14,
                          fontWeight: FontWeight.w700,
                          fontFamily: "Source Sans Pro",
                          color: const Color(0xffDC5F67),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Image.asset(
                      'packages/loyalty_program_frontend/assets/images/reward_point_coin.png',
                      width: kIsWeb ? 20 : 16,
                      height: kIsWeb ? 20 : 16,
                    )
                  ],
                ),
                SizedBox(height: size(widget.boxConstraints, 10)),
                // SizedBox(
                //   height: size(widget.boxConstraints, 32),
                //   width: size(widget.boxConstraints, 96),
                //   child: TextButton(
                //     onPressed: () {},
                //     style: ButtonStyle(
                //       padding:
                //           MaterialStateProperty.all(const EdgeInsets.all(2)),
                //       shape: MaterialStateProperty.all(
                //         RoundedRectangleBorder(
                //           side: const BorderSide(
                //             color: Colors.black,
                //             width: 0.7,
                //           ),
                //           borderRadius: BorderRadius.circular(
                //             size(widget.boxConstraints, 6),
                //           ),
                //         ),
                //       ),
                //     ),
                //     child: Text(
                //       'Resend Code',
                //       style: TextStyle(
                //         fontFamily: "Source Sans Pro",
                //         color: Colors.black,
                //         fontSize: size(widget.boxConstraints, 14),
                //       ),
                //     ),
                //   ),
                // ),
              ],
            )
          ],
        ),
      );
    }

    return Container(
      padding: kIsWeb
          ? EdgeInsets.only(
              left: size(widget.boxConstraints, 50),
              right: size(widget.boxConstraints, 50),
            )
          : const EdgeInsets.all(0),
      color: const Color(0xffFFEDEC),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: BlocBuilder<RewardPointsBloc, RewardPointsState>(
              buildWhen: (context, state) {
                return state is RewardPointsSuccess;
              },
              builder: (context, state) {
                if (state is RewardPointsSuccess) {
                  DebitActivity? jsonData =
                      state.pageInformation?.debitActivity;
                  List<String> listOfKeys =
                      jsonData!.debitActivityMap.keys.toList();
                  if (listOfKeys.isEmpty) {
                    return kIsWeb
                        ? emptyRedeemListBox(state)
                        : emptyRedeemListBoxMobile(state);
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (kIsWeb) ...[
                        Text(
                          "View your redeemed reward points.",
                          style: TextStyle(
                            fontSize: kIsWeb ? 16 : 14,
                            fontWeight: FontWeight.w600,
                            fontFamily: "Source Sans Pro",
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 18)
                      ],
                      Expanded(
                        child: ListView.separated(
                          shrinkWrap: true,
                          itemCount: listOfKeys.length,
                          itemBuilder: (BuildContext context, int index) {
                            List<dynamic> transactions = jsonData
                                .debitActivityMap[listOfKeys[index]]
                                .map((dynamic data) {
                              return Transaction.fromJson(
                                  json.decode(json.encode(data)));
                            }).toList();
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                redeemPointItemHeader(listOfKeys[index]),
                                ListView.separated(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  physics: const ScrollPhysics(),
                                  itemCount: transactions.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return redeemPointItemBody(
                                        transactions, index);
                                  },
                                  separatorBuilder: (context, index) {
                                    return const Divider(
                                      height: 1,
                                      color: Color(0xffcccdcd),
                                    );
                                  },
                                ),
                              ],
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox(height: 10);
                          },
                        ),
                      ),
                    ],
                  );
                }
                if (state is RewardPointsInProgress ||
                    state is RewardPointsInitial) {
                  return const Center(child: CircularProgressIndicator());
                }
                return Container(color: Colors.white);
              },
            ),
          )
        ],
      ),
    );
  }

  Container emptyRedeemListBoxMobile(RewardPointsSuccess state) {
    return Container(
      height: widget.boxConstraints.maxHeight,
      width: widget.boxConstraints.maxWidth,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 16),
          Text(
            state.pageInformation!.currentCredit! < 3000
                ? "Earn at least 3000 reward points in order to redeem & get a reward."
                : "Looks like you haven’t yet redeemed any reward points.",
            style: const TextStyle(
                fontSize: kIsWeb ? 16 : 14,
                fontWeight: FontWeight.w400,
                color: Colors.black),
          ),
          const SizedBox(
            height: 18,
          ),
          Image.asset(
            state.pageInformation!.currentCredit! < 3000
                ? "packages/loyalty_program_frontend/assets/images/coin.png"
                : "packages/loyalty_program_frontend/assets/images/confused.png",
            height: kIsWeb ? 32 : 28,
            width: kIsWeb ? 32 : 28,
          ),
          const SizedBox(height: 18),
          state.pageInformation!.currentCredit! < 3000
              ? InkWell(
                  onTap: () {
                    context.read<RewardPointsBloc>().add(ChangeTabIndex(1));
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: size(widget.boxConstraints, 40),
                    width: size(widget.boxConstraints, 144),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Color(0xFFba181c)),
                        borderRadius: BorderRadius.circular(4)),
                    child: Text(
                      "Earn More Points",
                      style: TextStyle(
                          color: Color(0xFFba181c),
                          fontSize: size(widget.boxConstraints, 12),
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                )
              : const Text(
                  "Tap ‘Redeem Reward Points’ to explore more.",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                      fontWeight: FontWeight.w500),
                )
        ],
      ),
    );
  }

  SizedBox emptyRedeemListBox(RewardPointsSuccess state) {
    return SizedBox(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (kIsWeb) ...[
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    state.pageInformation!.currentCredit! < 3000
                        ? 'Earn at least 3000 reward points in order to redeem & get a reward.'
                        : 'Looks like you haven’t yet redeemed any reward points.',
                    style: const TextStyle(
                      fontSize: kIsWeb ? 18 : 16,
                      fontWeight: FontWeight.w600,
                      fontFamily: "Source Sans Pro",
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
            ],
            const Text(
              'Your Reward Points',
              style: TextStyle(
                fontSize: kIsWeb ? 16 : 14,
                fontWeight: FontWeight.w600,
                color: Color(0xffba181c),
              ),
            ),
            const SizedBox(height: kIsWeb ? 16 : 12),
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Container(
                height: size(widget.boxConstraints, 180),
                width: size(widget.boxConstraints, 180),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFFFFFFFF),
                      Color.fromRGBO(255, 252, 252, 0.94),
                      Color.fromRGBO(255, 241, 240, 0.66),
                      Color(0xFFfac8b2),
                    ],
                    stops: [0.0, 0.4167, 0.6615, 1.0],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 3,
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: kIsWeb ? size(widget.boxConstraints, 38) : 20,
                    ),
                    SizedBox(
                      height: kIsWeb ? size(widget.boxConstraints, 65) : 60,
                      width: size(widget.boxConstraints, 65),
                      child: Image.asset(
                        'assets/images/coin.png',
                        package: 'loyalty_program_frontend',
                      ),
                    ),
                    SizedBox(
                        height: kIsWeb ? size(widget.boxConstraints, 15) : 8),
                    Text(
                      state.pageInformation?.currentCredit.toString() ?? "",
                      style: TextStyle(
                        fontSize: kIsWeb ? size(widget.boxConstraints, 20) : 20,
                        fontWeight: FontWeight.w900,
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: size(widget.boxConstraints, 30)),
            state.pageInformation!.currentCredit! < 3000
                ? InkWell(
                    onTap: () {
                      context.read<RewardPointsBloc>().add(ChangeTabIndex(1));
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: kIsWeb ? 40 : 36,
                      width: size(widget.boxConstraints, 152),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Color(0xFFba181c)),
                          borderRadius: BorderRadius.circular(4)),
                      child: Text(
                        "Earn More Points",
                        style: TextStyle(
                            color: Color(0xFFba181c),
                            fontSize: size(widget.boxConstraints, 14),
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  )
                : RewardRedeemButton(
                    boxConstraints: widget.boxConstraints,
                    onPress: () async {
                      context.read<RewardPointsBloc>().add(ChangeTabIndex(0));
                    },
                  ),
            SizedBox(height: kIsWeb ? 16 : 12),
          ],
        ),
      ),
    );
  }
}
