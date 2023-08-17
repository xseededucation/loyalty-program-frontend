import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:loyalty_program_frontend/helpers/intl_wrapper.dart';

import 'package:loyalty_program_frontend/helpers/tooltip_wrapper.dart';

class ProgressSlider extends StatefulWidget {
  final double currentAmount;
  final List<MileStone> mileStones;
  final String userName;
  final Function(double) onChange;
  final double width;
  const ProgressSlider(
      {super.key,
      required this.currentAmount,
      required this.mileStones,
      required this.userName,
      required this.onChange,
      required this.width});

  @override
  State<ProgressSlider> createState() => _ProgressSliderState();
}

class _ProgressSliderState extends State<ProgressSlider> {
  int? indexOfSelectedValue;
  int? motivationIndex;

  Future showToolTip() async {
    await Future.delayed(
      const Duration(
        milliseconds: 3,
      ),
    );
    ToolTipWrapper.showToolTip();
  }

  @override
  void initState() {
    ToolTipWrapper.initToolTipController();
    addCurrentAmountToList();
    sortMileStoneBasedOnAmount();
    getIndexForMotivationMessage();
    showToolTip();
    super.initState();
  }

  void getIndexForMotivationMessage() {
    for (int i = 0; i < widget.mileStones.length; i++) {
      if (widget.mileStones[i].amount == widget.currentAmount) {
        indexOfSelectedValue = i;
        break;
      }
    }
    if (indexOfSelectedValue == widget.mileStones.length - 1) {
      motivationIndex = -1;
    } else {
      motivationIndex = indexOfSelectedValue! + 1;
    }
  }

  void addCurrentAmountToList() {
    widget.mileStones.add(MileStone(amount: 0));
    bool isPresent = false;
    for (int i = 0; i < widget.mileStones.length; i++) {
      if (widget.mileStones[i].amount == widget.currentAmount) {
        isPresent = true;
        break;
      }
    }
    if (!isPresent) {
      widget.mileStones.add(
        MileStone(amount: widget.currentAmount),
      );
    }
  }

  void sortMileStoneBasedOnAmount() {
    widget.mileStones.sort(
      (a, b) => a.amount!.compareTo(b.amount!),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      child: Column(
        children: [
          const SizedBox(
            height: kIsWeb ? 60 : 30,
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
                      children: widget.mileStones
                          .map(
                            (e) => SizedBox(
                              width: kIsWeb ? 60 : 45,
                              child: e.amount == widget.currentAmount
                                  ? Center(
                                      child: Column(
                                        children: [
                                          Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              Image.asset(
                                                'assets/icons/current_status.png',
                                              ),
                                              Text(
                                                widget.userName[0],
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
                        min: widget.mileStones.first.amount!,
                        max: (widget.mileStones.length - 1).toDouble(),
                        divisions: widget.mileStones.length - 1,
                        value: indexOfSelectedValue!.toDouble(),
                        onChanged: (double value) {
                          setState(() {
                            indexOfSelectedValue = value.toInt();
                            widget.onChange(widget
                                .mileStones[indexOfSelectedValue!].amount!);
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
                      children: widget.mileStones
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
                                    color: widget
                                                .mileStones[
                                                    indexOfSelectedValue!
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
                  children: widget.mileStones
                      .map(
                        (e) => SizedBox(
                          child: motivationIndex != -1 &&
                                  e.amount ==
                                      widget.mileStones[motivationIndex!].amount
                              ? ToolTipWrapper.getToolTip(
                                  child: const SizedBox(),
                                  message: widget
                                      .mileStones[motivationIndex!].message,
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
  final String message;
  final double? amount;

  MileStone({this.message = "", required this.amount});
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
