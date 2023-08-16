import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';

class ToolTipWrapper {
  static JustTheController? _controller;

  static void initToolTipController() {
    _controller = JustTheController();
  }

  static void showToolTip() {
    _controller?.showTooltip();
  }

  static void hideToolTip() {
    _controller?.hideTooltip();
  }

  static Widget getToolTip({required Widget child, required String message}) {
    return JustTheTooltip(
      backgroundColor: const Color(0xffFFEAC1),
      preferredDirection: AxisDirection.up,
      controller: _controller,
      content: Container(
        color: const Color(0xffFFEAC1),
        width: kIsWeb ? 100 : 70,
        padding: const EdgeInsets.all(5),
        child: Text(
          message,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: kIsWeb ? 12 : 8,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      child: child,
    );
  }
}
