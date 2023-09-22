import 'package:flutter_test/flutter_test.dart';
import 'package:loyalty_program_frontend/presentation/utils/helpers/format_points.dart';

void main() {
  test('Test formatPoints', () {
    expect(formatPoints(1), "1");

    expect(formatPoints(12345), "12,345");
    expect(formatPoints(123456), "123,456");

    expect(formatPoints(1234567890), "1,234,567,890");

    expect(formatPoints(-1), "-1");
  });
}
