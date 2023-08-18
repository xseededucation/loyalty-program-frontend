import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class LoyaltyPointsChecker {
  bool appOpened = false;
  bool sessionStarted = false;
  bool lessonPlanClosed = false;

  // Timer
  Timer? timer;
  int counterSeconds = 0;
  late DateTime endTime;
  int endMinutes = 0;
  int endSeconds = 0;

  LoyaltyPointsChecker();

  init() {
    return true;
  }

  retrieveAppOpenedStatus() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

    String lastOpenedDate = sharedPreferences.getString('lastOpenedDate') ?? '';
    bool appOpened = sharedPreferences.getBool('appOpened') ?? false;

    print("currentDate : $currentDate");

    if (currentDate != lastOpenedDate) {
      sharedPreferences.setString('lastOpenedDate', currentDate);
      sharedPreferences.setBool('appOpened', false);
      appOpened = false;
    } else {
      appOpened = appOpened;
    }
    return appOpened;
  }

  // Timer
  Future<void> startTimer(int minutes) async {
    if (timer != null) {
      timer!.cancel();
    }

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    int loyaltyTimerSecondsAtCancel =
        sharedPreferences.getInt('loyaltyTimerSecondsAtCancel') ?? 0;

    print("startTimer : loyaltyTimerSecondsAtCancel :  $counterSeconds");

    endMinutes = minutes;
    endSeconds = minutes * 60;
    counterSeconds = loyaltyTimerSecondsAtCancel;

    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      counterSeconds = counterSeconds + 1;
      print("startTimer : $counterSeconds");

      sharedPreferences.setInt('loyaltyTimerSecondsAtCancel', counterSeconds);
      if (counterSeconds > endSeconds) {
        timer.cancel();
        print("Call API to update");
      }
    });
  }

  Future<void> cancelTimer() async {
    if (timer != null) {
      timer!.cancel();
    }
    print("cancelTimer : loyaltyTimerSecondsAtCancel : called");
  }

  Future<void> clearAll() async {
    if (timer != null) {
      timer!.cancel();
    }
    print("cancelTimer : loyaltyTimerSecondsAtCancel : called");

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
  }
}
