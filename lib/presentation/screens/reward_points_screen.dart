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
  RewardPointsBloc? _bloc;
  @override
  void initState() {
    Constants.userData = widget.userDetail;
    _bloc = BlocProvider.of<RewardPointsBloc>(context);
    _bloc?.add(FetchPageInformationEvent());

    super.initState();
  }

  Widget header(BoxConstraints constraints) {
    return Container(
      height: size(constraints, 100),
      constraints: const BoxConstraints(minHeight: 102),
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

  Widget verticalTab(BoxConstraints constraints) {
    return VerticalTabView(
      onSelect: (int tabIndex) {
        BlocProvider.of<RewardPointsBloc>(context)
            .add(FetchPageInformationEvent());
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
        BlocBuilder(
          bloc: _bloc,
          builder: (context, state) {
            if (state is RewardPointsSuccess) {
              if (state.isRedeemPageOpen != null &&
                  state.isRedeemPageOpen == true) {
                return const RedeemRewardScreen();
              } else {
                if (state.pageInformation == null ||
                    state.pageInformation?.currentCredit == null) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return AvailableRewardPoint(
                  pageInformation: state.pageInformation,
                  currentAchievementLevel: state.pointsToShow!,
                  onPress: () {
                    if (hasUserAchievedAnyMileStone(state.pageInformation!)) {
                      BlocProvider.of<RewardPointsBloc>(context)
                          .add(ToggleRedeemScreen(true));
                    }
                  },
                  boxConstraints: constraints,
                );
              }
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
        EarnPointScreen(boxConstraints: constraints),
        RedeemPointsScreen(boxConstraints: constraints),
        SingleChildScrollView(
          child: Container(
            constraints: BoxConstraints(minHeight: size(constraints, 350)),
            padding: kIsWeb
                ? EdgeInsets.only(
                    left: size(constraints, 50),
                    right: size(constraints, 50),
                    top: size(constraints, 20),
                    bottom: size(constraints, 20),
                  )
                : const EdgeInsets.all(0),
            color: const Color(0xffFFEDEC),
            child: BlocBuilder<RewardPointsBloc, RewardPointsState>(
              buildWhen: (context, state) {
                return state is RewardPointsSuccess;
              },
              builder: (context, state) {
                if (state is RewardPointsSuccess) {
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
                }
                return const SizedBox();
              },
            ),
          ),
        )
      ],
    );
  }

  Widget rewardPointCardView(BoxConstraints constraints) {
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
              constraints: const BoxConstraints(minHeight: 102),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  header(constraints),
                  Expanded(
                    child: Container(
                      constraints: const BoxConstraints(minHeight: 102),
                      height: size(constraints, 100),
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
                      child: BlocBuilder(
                        bloc: _bloc,
                        builder: (context, state) {
                          if (state is RewardPointsSuccess) {
                            if (state.pageInformation!.zeroCreditMessage !=
                                null) {
                              return ProgressSlider(
                                actualPoint: state
                                    .pageInformation!.currentCredit!
                                    .toDouble(),
                                tooltipMessageZeroIndex:
                                    state.pageInformation!.zeroCreditMessage ??
                                        "",
                                currentPoint: state.pointsToShow!,
                                conversionRates:
                                    state.pageInformation!.conversionRates!,
                                userName: "${Constants.userData?.name ?? ""}",
                                onChange: (double value) {
                                  context.read<RewardPointsBloc>().add(
                                        ChangeSliderPoints(value),
                                      );
                                },
                                width: constraints.maxWidth * 0.390,
                              );
                            }
                          }
                          return const Center(
                              child: CircularProgressIndicator());
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(child: verticalTab(constraints))
          ],
        ),
      ),
    );
  }

  Widget webView() {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Container(
          padding: EdgeInsets.only(
            left: (constraints.maxWidth / 6),
            right: (constraints.maxWidth / 6),
            top: (constraints.maxWidth / 50),
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
                child: rewardPointCardView(constraints),
              )
            ],
          ),
        );
      },
    );
  }

  Widget mobileView() {
    Terms? pageDetail;

    TabController tabController = TabController(length: 3, vsync: this);
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Scaffold(
          body: BlocConsumer<RewardPointsBloc, RewardPointsState>(
            buildWhen: (context, state) {
              return state is RewardPointsSuccess;
            },
            listenWhen: (previous, current) {
              return previous != current;
            },
            listener: (context, state) {
              if (state is RewardPointsSuccess) {
                if (state.changeTabIndex?['index'] != null) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    tabController.index = state.changeTabIndex?['index'] ?? 0;
                    setState(() {});
                  });
                }
              }
            },
            builder: (context, state) {
              if (state is RewardPointsSuccess) {
                if (state.pageInformation?.pageDetails != null) {
                  List<PageDetail> pageDetails =
                      state.pageInformation?.pageDetails as List<PageDetail>;
                  pageDetail = pageDetails.firstWhere((element) {
                    return element.toJson()["entityType"] == "Terms";
                  }) as Terms;
                }
                return state.isRedeemPageOpen!
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
                                SizedBox(height: size(constraints, 20)),
                                Text(
                                  "${Constants.userData?.name ?? ""}",
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                const Text(
                                  "Let's get started to earn rewards & much more!",
                                  style: TextStyle(fontSize: 14),
                                ),
                                SizedBox(
                                  height: 130,
                                  child: state.pageInformation
                                              ?.zeroCreditMessage !=
                                          null
                                      ? ProgressSlider(
                                          actualPoint: state
                                              .pageInformation!.currentCredit!
                                              .toDouble(),
                                          tooltipMessageZeroIndex: state
                                              .pageInformation!
                                              .zeroCreditMessage!,
                                          currentPoint: state.pointsToShow!,
                                          conversionRates: state
                                              .pageInformation!
                                              .conversionRates!,
                                          width: constraints.maxWidth,
                                          userName:
                                              "${Constants.userData?.name ?? ""}",
                                          onChange: (double value) {
                                            context
                                                .read<RewardPointsBloc>()
                                                .add(
                                                  ChangeSliderPoints(value),
                                                );
                                          },
                                        )
                                      : const SizedBox(),
                                ),
                                state.pageInformation != null &&
                                        state.pointsToShow != null
                                    ? RewardStatus(
                                        pointsToShow: state.pointsToShow!,
                                        pageInformation: state.pageInformation!,
                                        boxConstraints: constraints,
                                      )
                                    : const Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                state.pageInformation != null &&
                                        state.pageInformation!
                                                .conversionRates !=
                                            null
                                    ? RewardRedeemButton(
                                        isActive: hasUserAchievedAnyMileStone(
                                            state.pageInformation!),
                                        boxConstraints: constraints,
                                        onPress: () {
                                          if (hasUserAchievedAnyMileStone(
                                              state.pageInformation!)) {
                                            BlocProvider.of<RewardPointsBloc>(
                                                    context)
                                                .add(ToggleRedeemScreen(true));
                                          }
                                        },
                                      )
                                    : const SizedBox(),
                              ],
                            ),
                          ),
                          Container(
                            height: 44,
                            decoration: const BoxDecoration(
                              color: Color(0xFFfff2f1),
                            ),
                            padding: const EdgeInsets.only(top: 10),
                            child: TabBar(
                              controller: tabController,
                              indicatorPadding: EdgeInsets.zero,
                              labelPadding: EdgeInsets.zero,
                              padding: EdgeInsets.zero,
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
                                Container(
                                  padding: const EdgeInsets.only(
                                      left: 12, right: 12),
                                  margin: const EdgeInsets.only(top: 10),
                                  child: SingleChildScrollView(
                                    child: Text(
                                      "${pageDetail?.text}",
                                      style: TextStyle(
                                        fontSize: size(constraints, 12),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
              }
              return Container(color: Colors.white);
            },
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
        body: kIsWeb ? webView() : mobileView(),
      ),
    );
  }
}
