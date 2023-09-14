import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loyalty_program_frontend/presentation/utils/helpers/size_helper.dart';

void main() {
  test('Test size function', () {
    const constraints = BoxConstraints(maxHeight: 600.0);

    expect(size(constraints, 100), 100.0);

    expect(size(constraints, 500), 500.0);

    expect(size(constraints, 0), 0.0);

    expect(size(constraints, -100), -100.0);
  });
}
