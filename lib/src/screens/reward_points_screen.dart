import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:loyalty_program_frontend/loyalty_program_frontend.dart';
import 'package:loyalty_program_frontend/src/screens/redeem_points_screen.dart';
import '../utils/constant.dart';
import '../utils/vertical_tabview.dart';
import 'earn_points_screen.dart';

class RewardPointScreen extends StatefulWidget {
  const RewardPointScreen({super.key});

  @override
  State<RewardPointScreen> createState() => _RewardPointScreenState();
}

class _RewardPointScreenState extends State<RewardPointScreen>
    with SingleTickerProviderStateMixin {
  Widget header(BoxConstraints constraints) {
    return Container(
      height: size(constraints, 120),
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

  Widget progressBar(BoxConstraints constraints) {
    return Center(
      child: Text(
        'Progress Bar',
        style: TextStyle(
          fontSize: size(constraints, 18),
          fontWeight: FontWeight.w500,
          fontFamily: "Source Sans Pro",
        ),
      ),
    );
  }

  Widget verticalTab(BoxConstraints constraints) {
    return VerticalTabView(
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
        const Center(child: Text('Available Reward Points')),
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
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                header(constraints),
                Expanded(
                  child: Container(
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
                    child: progressBar(constraints),
                  ),
                )
              ],
            ),
            Expanded(
              child: verticalTab(constraints),
            )
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

  Widget mobileView() {
    TabController tabController = TabController(length: 3, vsync: this);
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Scaffold(
          body: Column(
            children: [
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
        body: kIsWeb ? webView() : mobileView(),
      ),
    );
  }
}
