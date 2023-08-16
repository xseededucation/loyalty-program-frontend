import 'package:intl/intl.dart';

class IntlWrapper {
  static String formatIndianCurrency(double amount) {
    final currencyFormat =
        NumberFormat.currency(locale: 'en_IN', symbol: '₹', decimalDigits: 2);

    String formattedAmount = currencyFormat.format(amount);

    if (formattedAmount.contains('.00')) {
      formattedAmount = formattedAmount.replaceAll('.00', '');
    }

    return formattedAmount;
  }
}
