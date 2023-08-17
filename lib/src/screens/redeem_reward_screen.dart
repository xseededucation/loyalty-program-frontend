import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class RedeemRewardScreen extends StatelessWidget {
  const RedeemRewardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        width: double.infinity,
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
              padding: const EdgeInsets.only(left: kIsWeb ? 22 : 12, top: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Redeem Reward Points",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Create a discount coupon and use it during checkout.",
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 50,
                ),
                SizedBox(
                  height: 137,
                  child: PageView.builder(
                    itemCount: 5,
                    scrollDirection: Axis.horizontal,                    
                    itemBuilder: (BuildContext context, int index) {
                      return Center(
                        child: Image.network(
                          "https://xseed-public-static-assets.s3.us-west-2.amazonaws.com/loyalty-program/amazon_card.png",
                          height: 137,
                          width: 244,
                          fit: BoxFit.contain,
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: kIsWeb? double.infinity: width * 0.8,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:  [
                       Column(
                         children: [
                           Text(
                            "Your points balance is 6,200 worth of ₹1,000. How many points do you want to redeem?",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                         ],
                       ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: CircleAvatar(
                        backgroundColor: Colors.black,
                        child: IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.add,
                              color: Colors.white,
                            )),
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          height: 50,
                          width: 108,
                          margin: const EdgeInsets.only(
                              top: 5, left: 16, right: 16, bottom: 5),
                          padding: const EdgeInsets.only(left: 5, right: 5),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: Color(0xffA5A5A5))),
                          alignment: Alignment.center,
                          child: SizedBox(
                            width: 60,
                            child: TextFormField(
                              initialValue: "300000",
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                  color: Colors.black),
                              decoration: const InputDecoration(
                                  border: InputBorder.none),
                            ),
                          ),
                        ),
                        const Text(
                          "Worth of ₹500",
                          style: TextStyle(
                              color: Color(0xff575757),
                              fontSize: 13,
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: CircleAvatar(
                        backgroundColor: Colors.black,
                        child: IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.remove,
                              color: Colors.white,
                            )),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                    height: 44,
                    width: 336,
                    padding: const EdgeInsets.only(
                        left: 11, top: 11, right: 11, bottom: 11),
                    decoration: BoxDecoration(
                        color: const Color(0xffFED945),
                        border: Border.all(color: const Color(0xffA5A5A5))),
                    alignment: Alignment.center,
                    child: const Text(
                      "Redeem",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
