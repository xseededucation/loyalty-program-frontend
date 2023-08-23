import 'package:flutter/foundation.dart';

class Constants {
  static const String baseUrl =
      "https://loyalty-program-apis.xseeddigital.info/api/";
  static dynamic userData;     
}

printLog(dynamic log) {
  if (kDebugMode) {
    print(log);
  }
}
