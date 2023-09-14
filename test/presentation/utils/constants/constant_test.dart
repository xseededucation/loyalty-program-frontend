import 'package:flutter_test/flutter_test.dart';
import 'package:loyalty_program_frontend/presentation/utils/constants/constant.dart';

void main() {
  test('Constants baseUrl should match the expected value', () {
    expect(Constants.baseUrl,
        "https://loyalty-program-apis.xseeddigital.info/api/");
  });

  test('Check the value of APP_OPEN constant', () {
    expect(APP_OPEN, 'APP_OPEN');
  });

  test('Check the value of SWIPE constant', () {
    expect(SWIPE, 'SWIPE');
  });

  test('Check the value of TIME_BOUND constant', () {
    expect(TIME_BOUND, 'TIME_BOUND');
  });

  test('Check the value of SHARED_PREF_LAST_OPENED constant', () {
    expect(SHARED_PREF_LAST_OPENED, 'lastOpenedDate');
  });

  test('Check the value of SHARED_PREF_LAST_TIME_BOUND constant', () {
    expect(SHARED_PREF_LAST_TIME_BOUND, 'timeBound');
  });
}
