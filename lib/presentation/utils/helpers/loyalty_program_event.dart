import 'dart:async';

import 'package:loyalty_program_frontend/presentation/utils/constants/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class LoyaltyProgramEvent {
  Timer? _timer;
  SharedPreferences? sharedPreferences;

  Future<void> initialize() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  void appOpened() async {
    String currentDate = _getCurrentDate();
    if (await _getAppLastOpenedDate() != currentDate) {
      _setLastOpenedDate(currentDate);
      _clearTimeBoundPref();
      _triggerApiCall(APP_OPEN);
    }
  }

  void stayedInApp(int mins) async {
    await _startTimer(mins);
  }

  void completedLesson() {
    _triggerApiCall(SWIPE);
  }

  Future<void> _startTimer(int mins) async {
    if (_timer != null) {
      _timer!.cancel();
    }
    final int timerInSeconds = mins * 60;
    int balanceSeconds = timerInSeconds - _getLasTimerInSeconds();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      balanceSeconds - 1;
      if (balanceSeconds > 0) {
        _setLastSetTimer(balanceSeconds);
      } else {
        timer.cancel();
        await _triggerApiCall(TIME_BOUND);
        _startTimer(mins);
      }
    });
  }

  Future<void> _triggerApiCall(String event) async {}

  void _clearTimeBoundPref() {
    sharedPreferences!.remove(SHARED_PREF_LAST_TIME_BOUND);
  }

  int _getLasTimerInSeconds() {
    return sharedPreferences!.getInt(SHARED_PREF_LAST_TIME_BOUND) ?? 0;
  }

  void _setLastOpenedDate(String currentDate) {
    sharedPreferences!.setString(SHARED_PREF_LAST_OPENED, currentDate);
  }

  void _setLastSetTimer(int time) {
    sharedPreferences!.setInt(SHARED_PREF_LAST_TIME_BOUND, time);
  }

  String _getAppLastOpenedDate() {
    return sharedPreferences!.getString(SHARED_PREF_LAST_OPENED) ?? '';
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
