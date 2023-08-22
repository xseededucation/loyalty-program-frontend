import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loyalty_program_frontend/loyalty_program_frontend.dart';
import 'package:loyalty_program_frontend/presentation/screens/available_reward_screen.dart';
import 'package:loyalty_program_frontend/presentation/screens/redeem_points_screen.dart';
import 'package:loyalty_program_frontend/presentation/screens/redeem_reward_screen.dart';
import 'package:loyalty_program_frontend/presentation/utils/external_packages/tooltip_wrapper.dart';
import 'package:loyalty_program_frontend/presentation/utils/helpers/size_helper.dart';
import 'package:loyalty_program_frontend/presentation/widgets/loader.dart';
import 'package:loyalty_program_frontend/presentation/widgets/widgets.dart';

import 'earn_points_screen.dart';

class RewardPointScreen extends StatefulWidget {
  const RewardPointScreen({super.key});

  @override
  State<RewardPointScreen> createState() => _RewardPointScreenState();
}

class _RewardPointScreenState extends State<RewardPointScreen>
    with TickerProviderStateMixin {
  RewardPointRepository? _rewardPointRepository;
  @override
  void initState() {
    _rewardPointRepository = RewardPointRepository();

    super.initState();
  }

  bool isRedeemRewardScreenOpen = false;
  List<MileStone> mileStones = [
    MileStone(message: 'winner winner chicken dinner', amount: 100),
    MileStone(message: 'winner winner chicken dinner', amount: 120),
    MileStone(message: 'winner winner chicken dinner', amount: 300),
  ];
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
            "Hi, Ayush",
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
        setState(() {
          isRedeemRewardScreenOpen = false;
        });
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
        isRedeemRewardScreenOpen
            ? const RedeemRewardScreen()
            : AvailableRewardPoint(
                onPress: () {
                  //todo add logic such that if user has reached first milestone then only it can go to redeem reward screen
                  setState(() {
                    isRedeemRewardScreenOpen = true;
                  });
                },
                message:
                    'Let’s get started to earn rewards & much more!', //todo message that will appear for each stages above "your reward points"
                boxConstraints: constraints,
              ),
        EarnPointScreen(boxConstraints: constraints),
        RedeemPointsScreen(boxConstraints: constraints),
        const Center(child: Text('Terms & Conditions')),
      ],
    );
  }

  Widget rewardPointCardView(BoxConstraints constraints) {
    return Card(
      elevation: 10,
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
                            width: 1.0,
                          ),
                          right: BorderSide(
                            color: Color(0xffCCCDCD),
                            width: 1.0,
                          ),
                          bottom: BorderSide(
                            color: Color(0xffCCCDCD),
                            width: 1.0,
                          ),
                        ),
                      ),
                      child: ProgressSlider(
                        currentAmount: 300, //todo current amount of user
                        mileStones:
                            mileStones, // todo list containig all the mile stones excluding current amount and 0(zero)
                        userName:
                            'Alok', // todo change username the first letter will be visible
                        onChange: (double value) {
                          //todo the value from slider will be here
                        },
                        width: constraints.maxWidth * 0.390,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: verticalTab(constraints),
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
              Expanded(child: rewardPointCardView(constraints))
            ],
          ),
        );
      },
    );
  }

  Widget mobileView(RewardPointsSuccess state) {
    TabController tabController = TabController(length: 3, vsync: this);
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Scaffold(
          body: isRedeemRewardScreenOpen
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
                          const Text(
                            'Hi Ayush',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w500),
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
                                width: constraints.maxWidth,
                                currentAmount: 220, //todo
                                mileStones: mileStones, //todo
                                userName: 'Alok', //todo
                                onChange: (v) {
                                  //todo
                                }),
                          ),
                          const SizedBox(
                            height: 17,
                          ),
                          RewardStatus(
                            currentAchievement: 4, //todo
                            totalMileStones: 5, //todo
                            points: 3000, //todo
                            boxConstraints: constraints,
                          ),
                          RewardRedeemButton(
                            boxConstraints: constraints,
                            onPress: () {
                              //todo goto redeem screen logic here only if user has reached first milestone
                              setState(() {
                                isRedeemRewardScreenOpen = true;
                              });
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
                          const Center(
                            child: Text(
                              'T&C',
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w600,
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
        body: BlocProvider<RewardPointsBloc>(
          create: (_) =>
              RewardPointsBloc(rewardPointRepository: _rewardPointRepository!)
                ..add(FetchPageInformationEvent()),
          child: Builder(builder: (context) {
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
                } else if (state is RewardPointsSuccess ||
                    state is RewardPointsFailure) {
                  LoadingDialog.hideLoadingDialog();
                }
              },
            );
          }),
        ),
      ),
    );
  }
}
