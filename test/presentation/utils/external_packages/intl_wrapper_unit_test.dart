import 'package:flutter_test/flutter_test.dart';
import 'package:loyalty_program_frontend/presentation/utils/external_packages/intl_wrapper.dart';

void main() {
  group('IntlWrapper test', () {
    test('formatIndianCurrency formats currency correctly', () {
      const amount = 123456.78;
      const expectedFormattedAmount = "₹1,23,456.78";
      final String formattedAmount = IntlWrapper.formatIndianCurrency(amount);
      expect(formattedAmount.toString(), expectedFormattedAmount);
    });
    test('formatIndianCurrency removes decimal part when .00', () {
      const amount = 1000.00;
      const expectedFormattedAmount = '₹1,000';

      final String formattedAmount = IntlWrapper.formatIndianCurrency(amount);

      expect(formattedAmount.toString(), expectedFormattedAmount);
    });
  });
}
