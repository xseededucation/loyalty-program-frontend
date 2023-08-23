import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loyalty_program_frontend/domain/models/page_information.dart';
import 'package:loyalty_program_frontend/presentation/utils/helpers/size_helper.dart';
import 'package:loyalty_program_frontend/presentation/widgets/loader.dart';

import '../../loyalty_program_frontend.dart';

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
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            '${earnMoreCredit[index].text}',
                            style: TextStyle(
                              fontSize: size(widget.boxConstraints, 14),
                              fontWeight: FontWeight.w600,
                              fontFamily: "Source Sans Pro",
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '${earnMoreCredit[index].subText}',
                            style: TextStyle(
                              fontSize: size(widget.boxConstraints, 12),
                              fontWeight: FontWeight.w500,
                              fontFamily: "Source Sans Pro",
                              color: const Color(0xff7887A5),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            '+ ${earnMoreCredit[index].credit}',
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
                fontSize: size(widget.boxConstraints, 15),
                fontWeight: FontWeight.w600,
                fontFamily: "Source Sans Pro",
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20),
          ],
          Expanded(
            child: BlocConsumer<RewardPointsBloc, RewardPointsState>(
              builder: (context, state) {
                print("pageInformation : builder : $state");
                if (state is RewardPointsSuccess) {
                  List<PageDetail> pageDetails =
                      state.pageInformation!.pageDetails as List<PageDetail>;

                  EarnMoreCredit pageDetail = pageDetails.firstWhere((element) {
                    return element.toJson()["entityType"] == "EarnMore";
                  }) as EarnMoreCredit;

                  return earnPointList(pageDetail.textToCredit);
                } else {
                  return const SizedBox();
                }
              },
              listener: (context, state) {
                print("pageInformation : listener : $state");
                if (state is RewardPointsInProgress) {
                  LoadingDialog.showLoadingDialog(context);
                } else if (state is RewardPointsSuccess ||
                    state is RewardPointsFailure) {
                  LoadingDialog.hideLoadingDialog(context);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
