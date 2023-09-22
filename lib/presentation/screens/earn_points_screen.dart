import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loyalty_program_frontend/domain/models/page_information.dart';
import 'package:loyalty_program_frontend/presentation/blocs/reward_points/reward_points_bloc.dart';
import 'package:loyalty_program_frontend/presentation/blocs/reward_points/reward_points_state.dart';
import 'package:loyalty_program_frontend/presentation/utils/helpers/size_helper.dart';

class EarnPointScreen extends StatefulWidget {
  BoxConstraints boxConstraints;
  EarnPointScreen({super.key, required this.boxConstraints});

  @override
  State<EarnPointScreen> createState() => _EarnPointScreenState();
}

class _EarnPointScreenState extends State<EarnPointScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget earnPointList(List<TextToCredit>? earnMoreCredit) {
      return ListView.separated(
        shrinkWrap: true,
        itemCount: earnMoreCredit!.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Card(
                elevation: 2,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: kIsWeb
                        ? Border.all(color: Colors.grey, width: 0.5)
                        : null,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            '${earnMoreCredit[index].text}',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: kIsWeb ? 16 : 14,
                              fontWeight:
                                  kIsWeb ? FontWeight.w600 : FontWeight.w500,
                              fontFamily: "Source Sans Pro",
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: kIsWeb ? 8 : 4),
                          Text(
                            '${earnMoreCredit[index].subText}',
                            overflow: TextOverflow.ellipsis,
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            '+ ${earnMoreCredit[index].credit}',
                            style: TextStyle(
                              fontSize: kIsWeb ? 14 : 12,
                              fontWeight: FontWeight.w700,
                              fontFamily: "Source Sans Pro",
                              color: const Color(0xff25AA62),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Image.asset(
                            'packages/loyalty_program_frontend/assets/images/reward_point_coin.png',
                            width: kIsWeb ? 20 : 18,
                            height: kIsWeb ? 20 : 18,
                          )
                        ],
                      )
                    ],
                  ),
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
      );
    }

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
              "Everytime you complete a lesson plan, you’ll earn more points.",
              style: TextStyle(
                fontSize: kIsWeb ? 16 : 14,
                fontWeight: FontWeight.w600,
                fontFamily: "Source Sans Pro",
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20),
          ],
          Expanded(
            child: BlocBuilder<RewardPointsBloc, RewardPointsState>(
              buildWhen: (context, state) {
                return state is RewardPointsSuccess;
              },
              builder: (context, state) {
                if (state is RewardPointsSuccess) {
                  EarnMoreCredit? pageDetail;
                  if (state.pageInformation?.pageDetails != null) {
                    List<PageDetail> pageDetails =
                        state.pageInformation?.pageDetails as List<PageDetail>;

                    pageDetail = pageDetails.firstWhere((element) {
                      return element.toJson()["entityType"] == "EarnMore";
                    }) as EarnMoreCredit;
                  }
                  if (pageDetail != null) {
                    return earnPointList(pageDetail.textToCredit);
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                }
                return Container(color: Colors.white);
              },
            ),
          )
        ],
      ),
    );
  }
}
