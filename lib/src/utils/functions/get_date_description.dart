import 'package:intl/intl.dart';

String getDateDescription(String inputDate) {
  DateTime now = DateTime.now();
  DateTime date = DateTime.parse(inputDate);

  if (date.year == now.year &&
      date.month == now.month &&
      date.day == now.day) {
    return 'Today';
  } else if (date.year == now.year &&
      date.month == now.month &&
      date.day == now.day - 1) {
    return 'Yesterday';
  } else if (date.isAfter(now.subtract(Duration(days: 7)))) {
    return 'Last week';
  } else if (date.year == now.year && date.month == now.month) {
    return 'Last month';
  } else if (date.year == now.year) {
    return 'Last year';
  } else {
    // Handle cases for older dates
    // String formattedDate = DateFormat('yyyy-MM-dd').format(date);
    String formattedDate = DateFormat('yyyy').format(date);
    return formattedDate;
  }
}

void main() {
  String inputDate = "2020-03-20T14:18:19.392+00:00";
  String description = getDateDescription(inputDate);
  print(description); // Output: "Last year"
}
