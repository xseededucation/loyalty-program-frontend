import 'dart:async';

import 'package:loyalty_program_frontend/data/repositories/reward_point_repository.dart';
import 'package:loyalty_program_frontend/presentation/utils/constants/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class LoyaltyProgramEvent {
  Timer? _timer;
  SharedPreferences? _sharedPreferences;
  RewardPointRepository? _rewardPointRepository;

  Future<void> initialize() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    _rewardPointRepository = RewardPointRepository();
  }

  void appOpened() async {
    String currentDate = _getCurrentDate();
    String lastOpenedDate = _getAppLastOpenedDate();
    if (lastOpenedDate != currentDate) {
      try {
        await _triggerApiCall(APP_OPEN);
        _setLastOpenedDate(currentDate);
        _clearTimeBoundPref();
      } catch (e) {}
    }
  }

  void stayedInApp(int mins) async {
    await _startTimer(mins);
  }

  void completedLesson() {
    _triggerApiCall(SWIPE);
  }

  Future<void> _startTimer(int mins) async {
    appOpened();
    if (_timer != null) {
      return;
    }
    final int timerInSeconds = mins * 60;
    int balanceSeconds = _getLasTimerInSeconds() ?? timerInSeconds;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      balanceSeconds = balanceSeconds - 1;
      if (balanceSeconds > 0) {
        _setLastSetTimer(balanceSeconds);
      } else {
        _timer!.cancel();
        _timer = null;
        _triggerApiCall(TIME_BOUND);
        _clearTimeBoundPref();
        _startTimer(mins);
      }
    });
  }

  Future<void> _triggerApiCall(String event) async {
    final response = await _rewardPointRepository!.updateUserActivity(event);
    if (response == null) {
      throw Exception();
    }
  }

  void _clearTimeBoundPref() {
    _sharedPreferences!.remove(SHARED_PREF_LAST_TIME_BOUND);
  }

  int? _getLasTimerInSeconds() {
    return _sharedPreferences!.getInt(SHARED_PREF_LAST_TIME_BOUND);
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
