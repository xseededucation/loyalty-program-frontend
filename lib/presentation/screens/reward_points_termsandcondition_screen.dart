import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_common_widgets/widgets/RichTextRenderer/rich_text_renderer.dart';
import 'package:loyalty_program_frontend/domain/models/page_information.dart';
import 'package:loyalty_program_frontend/loyalty_program_frontend.dart';
import 'package:loyalty_program_frontend/presentation/utils/constants/constant.dart';
import 'package:loyalty_program_frontend/presentation/utils/helpers/size_helper.dart';

class RewardPointTermsAndConditionScreen extends StatefulWidget {
  final dynamic userDetail;

  const RewardPointTermsAndConditionScreen(
      {super.key, required this.userDetail});

  @override
  State<RewardPointTermsAndConditionScreen> createState() =>
      _RewardPointTermsAndConditionScreenState();
}

class _RewardPointTermsAndConditionScreenState
    extends State<RewardPointTermsAndConditionScreen>
    with TickerProviderStateMixin {
  RewardPointsBloc? _bloc;

  @override
  void initState() {
    Constants.userData = widget.userDetail;
    _bloc = BlocProvider.of<RewardPointsBloc>(context);
    _bloc?.add(FetchPageInformationEvent());

    super.initState();
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
                return Container(
                  padding: const EdgeInsets.only(left: 12, right: 12),
                  margin: const EdgeInsets.only(top: 10),
                  child: SingleChildScrollView(
                    child: RichTextRenderer(
                      pageDetail?.text ??
                          '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text", text: "Loading..."}]}]}',
                      forceTextStyle: TextStyle(
                        fontSize: size(constraints, 12),
                      ),
                    ).documentToWidgetTree,
                  ),
                );
              }
              return Text(
                "Loading...",
                style: TextStyle(
                  fontSize: size(constraints, 12),
                  fontWeight: FontWeight.w500,
                ),
              );
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
        body: mobileView(),
      ),
    );
  }
}
