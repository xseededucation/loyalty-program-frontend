import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:loyalty_program_frontend/domain/models/page_information.dart';
import 'package:loyalty_program_frontend/presentation/utils/external_packages/intl_wrapper.dart';
import 'package:loyalty_program_frontend/presentation/utils/external_packages/tooltip_wrapper.dart';

class ProgressSlider extends StatefulWidget {
  final double currentPoint;
  final double actualPoint;
  final List<ConversionRates> conversionRates;
  final String userName;
  final Function(double) onChange;
  final double width;
  final String tooltipMessageZeroIndex;
  const ProgressSlider(
      {super.key,
      required this.currentPoint,
      required this.actualPoint,
      required this.conversionRates,
      required this.tooltipMessageZeroIndex,
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
    sortMileStoneBasedOnSequence();
    getCurrentIndex();
    modifyListBasedOnCurrentPoint();
    getIndexForMotivationMessage();
    showToolTip();
    super.initState();
  }

  @override
  void dispose() {
    ToolTipWrapper.dispose();
    super.dispose();
  }

  void addCurrentAmountToList() {
    bool isPresent = false;
    for (int i = 0; i < widget.conversionRates.length; i++) {
      MileStone obj = MileStone(
          sequence: widget.conversionRates[i].sequenceNo,
          amount: widget.conversionRates[i].denomination?.toDouble(),
          points: widget.conversionRates[i].credit?.toDouble(),
          toolTipMessage: widget.conversionRates[i].toolTipText!);
      mileStones.add(obj);

      if (widget.conversionRates[i].credit == 0) {
        isPresent = true;
      }
    }
    if (!isPresent) {
      mileStones.add(
        MileStone(amount: 0, points: 0, sequence: 0),
      );
    }
  }

  void getCurrentIndex() {
    if (widget.actualPoint > mileStones[mileStones.length - 1].points!) {
      indexOfSelectedValue = mileStones.length - 1;
      indexOfCurrentStatus = mileStones.length - 1;
      return;
    }
    for (int i = 0; i < mileStones.length; i++) {
      if (widget.actualPoint == mileStones[i].points!) {
        indexOfSelectedValue = i;
        indexOfCurrentStatus = i;
        break;
      } else if (widget.actualPoint < mileStones[i].points!) {
        indexOfSelectedValue = i - 1;
        indexOfCurrentStatus = i - 1;
        break;
      }
    }
  }

  void modifyListBasedOnCurrentPoint() {
    final obj = mileStones[indexOfCurrentStatus!];
    MileStone newObj = MileStone(
        amount: obj.amount,
        points: widget.currentPoint,
        toolTipMessage: obj.toolTipMessage,
        sequence: obj.sequence);
    mileStones.removeAt(indexOfCurrentStatus!);
    mileStones.add(newObj);
    sortMileStoneBasedOnSequence();
  }

  void getIndexForMotivationMessage() {
    if (indexOfSelectedValue == mileStones.length - 1) {
      motivationIndex = -1;
    } else {
      motivationIndex = indexOfSelectedValue! + 1;
    }
  }

  void sortMileStoneBasedOnSequence() {
    mileStones.sort(
      (a, b) => a.sequence!.compareTo(b.sequence!),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: kIsWeb ? 20 : 0),
      width: widget.width,
      child: Column(
        children: [
          const SizedBox(
            height: kIsWeb ? 10 : 30,
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
                                                widget.userName.isEmpty
                                                    ? ""
                                                    : widget.userName[0]
                                                        .toUpperCase(),
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
                                                fontSize: kIsWeb ? 10 : 8,
                                                letterSpacing:
                                                    kIsWeb ? 0.7 : null),
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
                          indexOfSelectedValue = value.toInt();
                          if (indexOfCurrentStatus! > indexOfSelectedValue!) {
                            return;
                          }
                          setState(
                            () {
                              if ((indexOfSelectedValue ==
                                      mileStones.length - 1) &&
                                  widget.currentPoint >
                                      mileStones[mileStones.length - 1]
                                          .points!) {
                                widget.onChange(widget.currentPoint);
                              } else {
                                widget.onChange(
                                    mileStones[indexOfSelectedValue!].points!);
                              }
                            },
                          );
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
                                  message: indexOfCurrentStatus == 0
                                      ? widget.tooltipMessageZeroIndex
                                      : mileStones[indexOfCurrentStatus!]
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
  final int? sequence;

  MileStone(
      {this.toolTipMessage = "",
      required this.amount,
      required this.points,
      required this.sequence});
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
