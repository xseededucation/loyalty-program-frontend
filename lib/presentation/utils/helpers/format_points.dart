String formatPoints(int value) {
  String formattedValue = value.toString();
  List<String> integralChunks = [];
  for (int i = formattedValue.length; i > 0; i -= 3) {
    int startIndex = i - 3 >= 0 ? i - 3 : 0;
    integralChunks.insert(0, formattedValue.substring(startIndex, i));
  }

  String formattedIntegralPart = integralChunks.join(',');

  return formattedIntegralPart;
}
