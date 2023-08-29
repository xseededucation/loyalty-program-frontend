import 'package:flutter/material.dart';

double size(BoxConstraints constraints, int constSize) {
  // Calculate a scaling factor based on the available height
  double scaleFactor = constraints.maxHeight / 650.0;
  double size = constSize * scaleFactor;
  return size;
}
