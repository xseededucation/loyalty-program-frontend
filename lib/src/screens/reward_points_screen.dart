import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../utils/constant.dart';
import '../utils/vertical_tabview.dart';

class RewardPointScreen extends StatefulWidget {
  const RewardPointScreen({super.key});

  @override
  State<RewardPointScreen> createState() => _RewardPointScreenState();
}

class _RewardPointScreenState extends State<RewardPointScreen> {
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
                Container(
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
                            color: Colors.white),
                      ),
                      Text(
                        "Hi, Ayush",
                        softWrap: true,
                        style: TextStyle(
                            fontSize: size(constraints, 14),
                            fontFamily: "Source Sans Pro",
                            color: Colors.white),
                      )
                    ],
                  ),
                ),
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
                    child: Center(
                      child: Text(
                        'Progress Bar',
                        style: TextStyle(
                          fontSize: size(constraints, 18),
                          fontWeight: FontWeight.w500,
                          fontFamily: "Source Sans Pro",
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            Expanded(
              child: VerticalTabView(
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
                contents: const <Widget>[
                  Center(
                    child: Text('Available Reward Points'),
                  ),
                  Center(
                    child: Text('Earn More Points'),
                  ),
                  Center(
                    child: Text('Redeemed Points'),
                  ),
                  Center(
                    child: Text('Terms & Conditions'),
                  ),
                ],
              ),
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
    return const Center(child: Text("WEB"));
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
