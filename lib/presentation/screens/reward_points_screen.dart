import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loyalty_program_frontend/domain/models/page_information.dart';
import 'package:loyalty_program_frontend/loyalty_program_frontend.dart';
import 'package:loyalty_program_frontend/presentation/screens/available_reward_screen.dart';
import 'package:loyalty_program_frontend/presentation/screens/redeem_points_screen.dart';
import 'package:loyalty_program_frontend/presentation/screens/redeem_reward_screen.dart';
import 'package:loyalty_program_frontend/presentation/utils/constants/constant.dart';
import 'package:loyalty_program_frontend/presentation/utils/external_packages/tooltip_wrapper.dart';
import 'package:loyalty_program_frontend/presentation/utils/helpers/has_user_achieved_any_milestone.dart';
import 'package:loyalty_program_frontend/presentation/utils/helpers/size_helper.dart';
import 'package:loyalty_program_frontend/presentation/widgets/dailogs/sucess_dailog.dart';
import 'package:loyalty_program_frontend/presentation/widgets/loader.dart';
import 'package:loyalty_program_frontend/presentation/widgets/widgets.dart';

import 'earn_points_screen.dart';

class RewardPointScreen extends StatefulWidget {
  final dynamic userDetail;
  const RewardPointScreen({super.key, required this.userDetail});

  @override
  State<RewardPointScreen> createState() => _RewardPointScreenState();
}

class _RewardPointScreenState extends State<RewardPointScreen>
    with TickerProviderStateMixin {
  @override
  void initState() {
    Constants.userData = widget.userDetail;
    BlocProvider.of<RewardPointsBloc>(context).add(FetchPageInformationEvent());

    super.initState();
  }

  double? pointToShow;
  Widget header(BoxConstraints constraints) {
    return Container(
      height: size(constraints, 120),
      constraints: const BoxConstraints(minHeight: 94),
      width: size(constraints, 300),
      decoration: const BoxDecoration(
        color: Color(0xFFBB151B),
        border: Border(
          bottom: BorderSide(
            color: Color(0xffCCCDCD),
            width: 1.0,
          ),
        ),
      ),
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.only(
        left: 20,
        top: 16,
        bottom: 16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Reward Points",
            softWrap: true,
            style: TextStyle(
              fontSize: size(constraints, 16),
              fontFamily: "Source Sans Pro",
              color: Colors.white,
            ),
          ),
          Text(
            "Hi, ${Constants.userData?.name ?? ""}",
            softWrap: true,
            style: TextStyle(
              fontSize: size(constraints, 14),
              fontFamily: "Source Sans Pro",
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }

  Widget verticalTab(BoxConstraints constraints, RewardPointsSuccess state) {
    return VerticalTabView(
      onSelect: (int tabIndex) {
        BlocProvider.of<RewardPointsBloc>(context)
            .add(ToggleRedeemScreen(false));
        if (tabIndex == 0) {
          ToolTipWrapper.showToolTip();
        }
      },
      backgroundColor: Colors.white,
      tabsWidth: size(constraints, 300),
      tabTextStyle: TextStyle(fontSize: constraints.maxHeight / 42),
      tabs: <Tab>[
        Tab(
          child: Text(
            'Available Reward Points',
            style: TextStyle(
              fontSize: size(constraints, 14),
              fontWeight: FontWeight.w600,
              fontFamily: "Source Sans Pro",
            ),
          ),
        ),
        Tab(
          child: Text(
            'Earn More Points',
            style: TextStyle(
              fontSize: size(constraints, 14),
              fontWeight: FontWeight.w600,
              fontFamily: "Source Sans Pro",
            ),
          ),
        ),
        Tab(
          child: Text(
            'Redeemed Points',
            style: TextStyle(
              fontSize: size(constraints, 14),
              fontWeight: FontWeight.w600,
              fontFamily: "Source Sans Pro",
            ),
          ),
        ),
        Tab(
          child: Text(
            'Terms & Conditions',
            style: TextStyle(
              fontSize: size(constraints, 14),
              fontWeight: FontWeight.w600,
              fontFamily: "Source Sans Pro",
            ),
          ),
        ),
      ],
      contents: <Widget>[
        BlocBuilder<RewardPointsBloc, RewardPointsState>(
          bloc: context.read<RewardPointsBloc>(),
          builder: (_, state) {
            if (state is RewardPointsSuccess) {
              if (state.isRedeemPageOpen != null &&
                  state.isRedeemPageOpen == true) {
                return const RedeemRewardScreen();
              } else {
                return AvailableRewardPoint(
                  pageInformation: state.pageInformation!,
                  currentAchievementLevel: pointToShow!.toDouble(),
                  onPress: () {
                    BlocProvider.of<RewardPointsBloc>(context)
                        .add(ToggleRedeemScreen(true));
                  },
                  message: 'Let’s get started to earn rewards & much more!',
                  boxConstraints: constraints,
                );
              }
            }
            return const SizedBox();
          },
        ),
        EarnPointScreen(boxConstraints: constraints),
        RedeemPointsScreen(boxConstraints: constraints),
        Container(
          padding: kIsWeb
              ? EdgeInsets.only(
                  left: size(constraints, 50),
                  right: size(constraints, 50),
                  top: size(constraints, 40),
                  bottom: size(constraints, 20),
                )
              : const EdgeInsets.all(0),
          color: const Color(0xffFFEDEC),
          child: Builder(
            builder: (context) {
              List<PageDetail> pageDetails =
                  state.pageInformation!.pageDetails as List<PageDetail>;

              Terms pageDetail = pageDetails.firstWhere((element) {
                return element.toJson()["entityType"] == "Terms";
              }) as Terms;
              return Text(
                '${pageDetail.text}',
                style: TextStyle(
                  fontSize: size(constraints, 14),
                  fontWeight: FontWeight.w600,
                  fontFamily: "Source Sans Pro",
                ),
              );
            },
          ),
        )
      ],
    );
  }

  Widget rewardPointCardView(
      BoxConstraints constraints, RewardPointsSuccess state) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              constraints: const BoxConstraints(minHeight: 94),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  header(constraints),
                  Expanded(
                    child: Container(
                      constraints: const BoxConstraints(minHeight: 94),
                      height: size(constraints, 120),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        border: Border(
                          top: BorderSide(
                            color: Color(0xffCCCDCD),
                            width: 0.4,
                          ),
                          right: BorderSide(
                            color: Color(0xffCCCDCD),
                            width: 0.4,
                          ),
                          bottom: BorderSide(
                            color: Color(0xffCCCDCD),
                            width: 0.4,
                          ),
                        ),
                      ),
                      child: ProgressSlider(
                        tooltipMessageZeroIndex:
                            state.pageInformation!.zeroCreditMessage ?? "",
                        currentPoint:
                            state.pageInformation!.currentCredit!.toDouble(),
                        conversionRates:
                            state.pageInformation!.conversionRates!,
                        userName: "${Constants.userData?.name ?? ""}",
                        onChange: (double value) {
                          setState(() {
                            pointToShow = value;
                          });
                        },
                        width: constraints.maxWidth * 0.390,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: verticalTab(constraints, state),
            )
          ],
        ),
      ),
    );
  }

  Widget webView(RewardPointsSuccess state) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Container(
          padding: EdgeInsets.only(
            left: (constraints.maxWidth / 6),
            right: (constraints.maxWidth / 6),
            top: (constraints.maxWidth / 30),
            bottom: (constraints.maxWidth / 100),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Teach, Earn & Be Rewarded",
                key: const Key('teachEarnRewardedText'),
                style: TextStyle(
                  fontSize: size(constraints, 18),
                  fontWeight: FontWeight.w600,
                  fontFamily: "Source Sans Pro",
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: rewardPointCardView(constraints, state),
              )
            ],
          ),
        );
      },
    );
  }

  Widget mobileView(RewardPointsSuccess state) {
    List<PageDetail> pageDetails =
        state.pageInformation!.pageDetails as List<PageDetail>;

    Terms pageDetail = pageDetails.firstWhere((element) {
      return element.toJson()["entityType"] == "Terms";
    }) as Terms;

    TabController tabController = TabController(length: 3, vsync: this);
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Scaffold(
          body: state.isRedeemPageOpen!
              ? const RedeemRewardScreen()
              : Column(
                  children: [
                    Container(
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
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 17),
                          Text(
                            "${Constants.userData?.name ?? ""}",
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          const Text(
                            "Let's get started to earn rewards & much more!",
                            style: TextStyle(fontSize: 12),
                          ),
                          SizedBox(
                            height: 130,
                            child: ProgressSlider(
                                tooltipMessageZeroIndex:
                                    state.pageInformation!.zeroCreditMessage!,
                                currentPoint: state
                                    .pageInformation!.currentCredit!
                                    .toDouble(),
                                conversionRates:
                                    state.pageInformation!.conversionRates!,
                                width: constraints.maxWidth,
                                userName: "${Constants.userData?.name ?? ""}",
                                onChange: (double value) {
                                  setState(() {
                                    pointToShow = value;
                                  });
                                }),
                          ),
                          const SizedBox(
                            height: 17,
                          ),
                          RewardStatus(
                            pointsToShow: pointToShow!,
                            pageInformation: state.pageInformation!,
                            boxConstraints: constraints,
                          ),
                          RewardRedeemButton(
                            boxConstraints: constraints,
                            onPress: () {
                              if (hasUserAchievedAnyMileStone(
                                  state.pageInformation!)) {
                                BlocProvider.of<RewardPointsBloc>(context)
                                    .add(ToggleRedeemScreen(true));
                              }
                            },
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: 45,
                      decoration: const BoxDecoration(
                        color: Color(0xFFfff2f1),
                      ),
                      child: TabBar(
                        controller: tabController,
                        indicator: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Color(0xFFBB151B),
                              width: 1.0,
                            ),
                          ),
                        ),
                        labelColor: const Color(0xFFBB151B),
                        labelStyle: TextStyle(
                          fontSize: size(constraints, 12),
                          fontFamily: "Source Sans Pro",
                          color: const Color(0xFFBB151B),
                        ),
                        unselectedLabelColor: Colors.black,
                        tabs: const [
                          Tab(text: 'EARN MORE'),
                          Tab(text: 'REDEEMED POINTS'),
                          Tab(text: 'T&C'),
                        ],
                      ),
                    ),
                    Expanded(
                      child: TabBarView(
                        controller: tabController,
                        children: [
                          EarnPointScreen(boxConstraints: constraints),
                          RedeemPointsScreen(boxConstraints: constraints),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 12, right: 12, top: 22),
                            child: Text(
                              pageDetail.text ?? "",
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: const Color(0xFFFFF8F8),
          body: LayoutBuilder(builder: (context, constraints) {
            return BlocConsumer<RewardPointsBloc, RewardPointsState>(
              builder: (context, state) {
                if (state is RewardPointsSuccess) {
                  if (kIsWeb) {
                    return webView(state);
                  } else {
                    return mobileView(state);
                  }
                } else {
                  return const SizedBox();
                }
              },
              listener: (context, state) {
                if (state is RewardPointsInProgress) {
                  LoadingDialog.showLoadingDialog(context);
                } else if (state is RewardPointsSuccess) {
                  setState(() {
                    pointToShow =
                        state.pageInformation!.currentCredit!.toDouble();
                  });
                  LoadingDialog.hideLoadingDialog(context);
                  if (state.eventType == 'makePayment') {
                    _showSuccessDialog(context, constraints);
                  }
                } else if (state is RewardPointsFailure) {
                  LoadingDialog.hideLoadingDialog(context);
                }
              },
            );
          })),
    );
  }

  void _showSuccessDialog(
      BuildContext context, BoxConstraints constraints) async {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return SuccessDialogBox(constraints: constraints);
      },
    );
  }
}
