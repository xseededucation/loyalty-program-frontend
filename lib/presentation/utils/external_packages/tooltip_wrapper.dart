import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';

class ToolTipWrapper {
  static JustTheController? _controller;

  static void initToolTipController() {
    _controller = JustTheController();
  }

  static Future<void> showToolTip() async {
    if (_controller != null) {
      await _controller?.showTooltip();
    }
  }

  static Future<void> hideToolTip() async {
    if (_controller != null) {
      await _controller?.hideTooltip();
    }
  }

  static void dispose() {
    _controller?.dispose();
  }

  static Widget getToolTip({required Widget child, required String message}) {
    return JustTheTooltip(
      backgroundColor: const Color(0xffFFEAC1),
      preferredDirection: AxisDirection.up,
      controller: _controller,
      content: Container(
        color: const Color(0xffFFEAC1),
        width: kIsWeb ? 100 : 70,
        padding: const EdgeInsets.only(left: 5, right: 5, top: 10, bottom: 10),
        child: Text(
          message,
          style: const TextStyle(
            fontWeight: kIsWeb ? FontWeight.w500 : FontWeight.w400,
            fontSize: kIsWeb ? 12 : 8,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      child: child,
    );
  }
}
