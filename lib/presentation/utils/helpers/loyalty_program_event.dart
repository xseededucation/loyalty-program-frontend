import 'dart:async';

import 'package:loyalty_program_frontend/presentation/utils/constants/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class LoyaltyProgramEvent {
  void appOpened() async {
    String currentDate = _getCurrentDate();
    if (await _getAppLastOpenedDate() != currentDate) {
      _setLastOpenedDate(currentDate);
      _triggerApiCall(APP_OPEN);
    }
  }

  void stayedInApp() {
    _triggerApiCall(TIME_BOUND);
  }

  void completedLesson() {
    _triggerApiCall(SWIPE);
  }

  void _triggerApiCall(String event) async {}

  void _setLastOpenedDate(String currentDate) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(SHARED_PREF_LAST_OPENED, currentDate);
  }

  Future<String> _getAppLastOpenedDate() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(SHARED_PREF_LAST_OPENED) ?? '';
  }

  String _getCurrentDate() {
    return DateFormat('yyyy-MM-dd').format(DateTime.now());
  }
}


// class LoyaltyProgramEvents {
//   bool appOpened = false;
//   bool sessionStarted = false;
//   bool lessonPlanClosed = false;

//   // Timer
//   Timer? timer;
//   int counterSeconds = 0;
//   late DateTime endTime;
//   int endMinutes = 0;
//   int endSeconds = 0;


//   retrieveAppOpenedStatus() async {
//     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//     String currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

//     String lastOpenedDate = sharedPreferences.getString('lastOpenedDate') ?? '';
//     bool appOpened = sharedPreferences.getBool('appOpened') ?? false;

//     print("currentDate : $currentDate");

//     if (currentDate != lastOpenedDate) {
//       sharedPreferences.setString('lastOpenedDate', currentDate);
//       sharedPreferences.setBool('appOpened', false);
//       appOpened = false;
//     } else {
//       appOpened = appOpened;
//     }
//     return appOpened;
//   }

//   // Timer
//   Future<void> startTimer(int minutes) async {
//     if (timer != null) {
//       timer!.cancel();
//     }

//     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//     int loyaltyTimerSecondsAtCancel =
//         sharedPreferences.getInt('loyaltyTimerSecondsAtCancel') ?? 0;

//     print("startTimer : loyaltyTimerSecondsAtCancel :  $counterSeconds");

//     endMinutes = minutes;
//     endSeconds = minutes * 60;
//     counterSeconds = loyaltyTimerSecondsAtCancel;

//     timer = Timer.periodic(const Duration(seconds: 1), (timer) {
//       counterSeconds = counterSeconds + 1;
//       print("startTimer : $counterSeconds");

//       sharedPreferences.setInt('loyaltyTimerSecondsAtCancel', counterSeconds);
//       if (counterSeconds > endSeconds) {
//         timer.cancel();
//         print("Call API to update");
//       }
//     });
//   }

//   Future<void> cancelTimer() async {
//     if (timer != null) {
//       timer!.cancel();
//     }
//     print("cancelTimer : loyaltyTimerSecondsAtCancel : called");
//   }

//   Future<void> clearAll() async {
//     if (timer != null) {
//       timer!.cancel();
//     }
//     print("cancelTimer : loyaltyTimerSecondsAtCancel : called");

//     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//     sharedPreferences.clear();
//   }
// }
