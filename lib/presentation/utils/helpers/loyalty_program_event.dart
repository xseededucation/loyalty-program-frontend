import 'dart:async';

import 'package:loyalty_program_frontend/presentation/utils/constants/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class LoyaltyProgramEvent {
  Timer? _timer;
  SharedPreferences? _sharedPreferences;

  Future<void> initialize() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  void appOpened() async {
    String currentDate = _getCurrentDate();
    String lastOpenedDate = _getAppLastOpenedDate();
    if (lastOpenedDate != currentDate) {
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

  Future<void> _triggerApiCall(String event) async {
    print('TRIGGER API CALL $event');
  }

  void _clearTimeBoundPref() {
    _sharedPreferences!.remove(SHARED_PREF_LAST_TIME_BOUND);
  }

  int _getLasTimerInSeconds() {
    return _sharedPreferences!.getInt(SHARED_PREF_LAST_TIME_BOUND) ?? 0;
  }

  void _setLastOpenedDate(String currentDate) {
    _sharedPreferences!.setString(SHARED_PREF_LAST_OPENED, currentDate);
  }

  void _setLastSetTimer(int time) {
    _sharedPreferences!.setInt(SHARED_PREF_LAST_TIME_BOUND, time);
  }

  String _getAppLastOpenedDate() {
    return _sharedPreferences!.getString(SHARED_PREF_LAST_OPENED) ?? '';
  }

  String _getCurrentDate() {
    return DateFormat('yyyy-MM-dd').format(DateTime.now());
  }
}
