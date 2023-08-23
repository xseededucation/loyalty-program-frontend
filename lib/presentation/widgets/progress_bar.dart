import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:loyalty_program_frontend/domain/models/page_information.dart';
import 'package:loyalty_program_frontend/presentation/utils/external_packages/intl_wrapper.dart';
import 'package:loyalty_program_frontend/presentation/utils/external_packages/tooltip_wrapper.dart';

class ProgressSlider extends StatefulWidget {
  final double currentPoint;
  final List<ConversionRates> conversionRates;
  final String userName;
  final Function(double) onChange;
  final double width;
  const ProgressSlider(
      {super.key,
      required this.currentPoint,
      required this.conversionRates,
      required this.userName,
      required this.onChange,
      required this.width});

  @override
  State<ProgressSlider> createState() => _ProgressSliderState();
}

class _ProgressSliderState extends State<ProgressSlider> {
  int? indexOfSelectedValue;
  int? indexOfCurrentStatus;
  int? motivationIndex;
  List<MileStone> mileStones = [];

  Future showToolTip() async {
    if (motivationIndex != -1) {
      await Future.delayed(
        const Duration(
          seconds: 3,
        ),
      );
      await ToolTipWrapper.showToolTip();
    }
  }

  @override
  void initState() {
    ToolTipWrapper.initToolTipController();
    addCurrentAmountToList();
    sortMileStoneBasedOnPoints();
    getIndexForMotivationMessage();
    showToolTip();
    super.initState();
  }

  @override
  void dispose() {
    ToolTipWrapper.dispose();
    super.dispose();
  }

  void getIndexForMotivationMessage() {
    for (int i = 0; i < mileStones.length; i++) {
      if (widget.currentPoint <= mileStones[i].points!) {
        indexOfSelectedValue = i;
        indexOfCurrentStatus = i;
        break;
      }
    }
    if (indexOfSelectedValue == mileStones.length - 1) {
      motivationIndex = -1;
    } else {
      motivationIndex = indexOfSelectedValue! + 1;
    }
  }

  void addCurrentAmountToList() {
    bool isPresent = false;
    for (int i = 0; i < widget.conversionRates.length; i++) {
      MileStone obj = MileStone(
          amount: widget.conversionRates[i].denomination?.toDouble(),
          points: widget.conversionRates[i].credit?.toDouble(),
          toolTipMessage: "winner winner chicken dinner");
      mileStones.add(obj);

      if (widget.conversionRates[i].credit == 0) {
        isPresent = true;
      }
    }
    if (!isPresent) {
      mileStones.add(
        MileStone(amount: 0, points: 0),
      );
    }
  }

  void sortMileStoneBasedOnPoints() {
    mileStones.sort(
      (a, b) => a.points!.compareTo(b.points!),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      child: Column(
        children: [
          const SizedBox(
            height: kIsWeb ? 0 : 30,
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              Column(
                children: [
                  Container(
                    padding: kIsWeb
                        ? EdgeInsets.zero
                        : const EdgeInsets.only(left: 8, right: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: mileStones
                          .map(
                            (e) => SizedBox(
                              width: kIsWeb ? 60 : 45,
                              child: e == mileStones[indexOfCurrentStatus!]
                                  ? Center(
                                      child: Column(
                                        children: [
                                          Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              Image.asset(
                                                'assets/icons/current_status.png',
                                                package:
                                                    'loyalty_program_frontend',
                                              ),
                                              Text(
                                                widget.userName[0].toString(),
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.white),
                                              )
                                            ],
                                          ),
                                          const Text(
                                            'You are here',
                                            style: TextStyle(
                                                fontSize: kIsWeb ? 10 : 8),
                                            textAlign: TextAlign.center,
                                          )
                                        ],
                                      ),
                                    )
                                  : null,
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: SliderTheme(
                      data: SliderThemeData(
                        thumbShape: CustomSliderThumbShape(),
                        overlayShape: const RoundSliderOverlayShape(
                          overlayRadius: 0,
                        ),
                        trackHeight: 4,
                        activeTrackColor: const Color(0xffe26063),
                        inactiveTrackColor: const Color(0xffffedec),
                        thumbColor: Colors.white,
                      ),
                      child: Slider(
                        min: mileStones.first.amount!,
                        max: (mileStones.length - 1).toDouble(),
                        divisions: mileStones.length - 1,
                        value: indexOfSelectedValue!.toDouble(),
                        onChanged: (double value) {
                          setState(() {
                            indexOfSelectedValue = value.toInt();
                            widget.onChange(
                                mileStones[indexOfSelectedValue!].points!);
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: mileStones
                          .map(
                            (e) => SizedBox(
                              width: 45,
                              child: Center(
                                child: Text(
                                  IntlWrapper.formatIndianCurrency(e.amount!),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                    color: mileStones[indexOfSelectedValue!
                                                    .toInt()]
                                                .amount ==
                                            e.amount
                                        ? const Color(0xffba181c)
                                        : Colors.transparent,
                                  ),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 32, right: 32),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: mileStones
                      .map(
                        (e) => SizedBox(
                          child: motivationIndex != -1 &&
                                  e == mileStones[motivationIndex!]
                              ? ToolTipWrapper.getToolTip(
                                  child: const SizedBox(),
                                  message: mileStones[motivationIndex!]
                                      .toolTipMessage,
                                )
                              : null,
                        ),
                      )
                      .toList(),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class MileStone {
  final String toolTipMessage;
  final double? amount;
  final double? points;

  MileStone(
      {this.toolTipMessage = "", required this.amount, required this.points});
}

class CustomSliderThumbShape extends SliderComponentShape {
  final double thumbRadius;
  final double thumbInnerRadius;

  CustomSliderThumbShape({
    this.thumbRadius = 10,
    this.thumbInnerRadius = 6,
  });

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size(thumbRadius * 2, thumbRadius * 2);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    Animation<double>? activationAnimation,
    Animation<double>? enableAnimation,
    bool? isDiscrete,
    TextPainter? labelPainter,
    RenderBox? parentBox,
    SliderThemeData? sliderTheme,
    TextDirection? textDirection,
    double? value,
    double? textScaleFactor,
    Size? sizeWithOverflow,
  }) {
    final Canvas canvas = context.canvas;

    final shadowPaint = Paint()
      ..color = Colors.black.withOpacity(0.2)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3);

    final thumbPaint = Paint()..color = sliderTheme!.thumbColor!;
    final thumbInnerPaint = Paint()..color = const Color(0xffba181c);

    canvas.drawCircle(center, thumbRadius + 2, shadowPaint);

    canvas.drawCircle(center, thumbRadius, thumbPaint);
    canvas.drawCircle(center, thumbInnerRadius, thumbInnerPaint);
  }
}
