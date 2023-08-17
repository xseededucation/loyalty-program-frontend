import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:loyalty_program_frontend/presentation/utils/helpers/size_helper.dart';

class EarnPointScreen extends StatefulWidget {
  BoxConstraints boxConstraints;
  EarnPointScreen({super.key, required this.boxConstraints});

  @override
  State<EarnPointScreen> createState() => _EarnPointScreenState();
}

class _EarnPointScreenState extends State<EarnPointScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: kIsWeb
          ? EdgeInsets.only(
              left: size(widget.boxConstraints, 50),
              right: size(widget.boxConstraints, 50),
              top: size(widget.boxConstraints, 40),
              bottom: size(widget.boxConstraints, 20),
            )
          : const EdgeInsets.all(0),
      color: kIsWeb ? const Color(0xffFFEDEC) : Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          if (kIsWeb) ...[
            Text(
              'Everytime you complete a lesson plan, you’ll earn more points.',
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
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: kIsWeb
                              ? Border.all(color: Colors.grey, width: 0.5)
                              : null,
                          borderRadius: BorderRadius.circular(
                            size(widget.boxConstraints, 4),
                          )),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Open SuperTeacher app & earn',
                                style: TextStyle(
                                  fontSize: size(widget.boxConstraints, 14),
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "Source Sans Pro",
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Start using SuperTeacher app',
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
                          Row(
                            children: [
                              Text(
                                '+50',
                                style: TextStyle(
                                  fontSize: size(widget.boxConstraints, 14),
                                  fontWeight: FontWeight.w700,
                                  fontFamily: "Source Sans Pro",
                                  color: const Color(0xff25AA62),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Image.asset(
                                'packages/loyalty_program_frontend/assets/images/reward_point_coin.png',
                                width: size(widget.boxConstraints, 20),
                                height: size(widget.boxConstraints, 20),
                              )
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                );
              },
              separatorBuilder: (context, index) {
                return kIsWeb
                    ? const SizedBox(height: 12)
                    : const Divider(color: Colors.grey);
              },
            ),
          ),
        ],
      ),
    );
  }
}
