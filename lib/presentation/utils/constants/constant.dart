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

const String APP_OPEN = 'APP_OPEN';
const String SWIPE = 'SWIPE';
const String TIME_BOUND = 'TIME_BOUND';

const String SHARED_PREF_LAST_OPENED = 'lastOpenedDate';
