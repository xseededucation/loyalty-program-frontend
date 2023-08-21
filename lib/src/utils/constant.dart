import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Constants {
  static const String baseUrl = "http://117.195.112.195:8245/api/";
}

double size(BoxConstraints constraints, int constSize) {
  // Calculate a scaling factor based on the available height
  double scaleFactor = constraints.maxHeight / 750.0;
  double size = constSize * scaleFactor;
  return size;
}

printLog(dynamic log) {
  if (kDebugMode) {
    print(log);
  }
}
