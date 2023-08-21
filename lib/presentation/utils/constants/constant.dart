import 'package:flutter/foundation.dart';

class Constants {
  static const String baseUrl = "http://117.195.112.195:8245/api/";
}

printLog(dynamic log) {
  if (kDebugMode) {
    print(log);
  }
}
