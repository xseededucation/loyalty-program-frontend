import 'package:flutter_test/flutter_test.dart';
import 'package:loyalty_program_frontend/domain/models/page_information.dart';
import 'package:loyalty_program_frontend/presentation/utils/helpers/redeem_reward_utils.dart';

void main() {
  test('Test findNearestLastCredit', () {
    expect(RedeemRewardUtils.findNearestLastCredit([], 100), 0);

    final conversionRates = [
      ConversionRates(credit: 50),
      ConversionRates(credit: 100),
      ConversionRates(credit: 200),
    ];

    expect(RedeemRewardUtils.findNearestLastCredit(conversionRates, 75), 50);

    expect(RedeemRewardUtils.findNearestLastCredit(conversionRates, 150), 100);

    expect(RedeemRewardUtils.findNearestLastCredit(conversionRates, 250), 200);
  });

  test('Test findDenomination', () {
    expect(RedeemRewardUtils.findDenomination([], 100), 0);

    final conversionRates = [
      ConversionRates(credit: 50, denomination: 5),
      ConversionRates(credit: 100, denomination: 10),
      ConversionRates(credit: 200, denomination: 20),
    ];

    expect(RedeemRewardUtils.findDenomination(conversionRates, 75), 5);

    expect(RedeemRewardUtils.findDenomination(conversionRates, 150), 10);
    expect(RedeemRewardUtils.findDenomination(conversionRates, 250), 20);
  });

  test('Test getNextCredit', () {
    expect(RedeemRewardUtils.getNextCredit([], 100), 100);

    final conversionRates = [
      ConversionRates(credit: 50),
      ConversionRates(credit: 100),
      ConversionRates(credit: 200),
    ];

    expect(RedeemRewardUtils.getNextCredit(conversionRates, 75), 100);
    expect(RedeemRewardUtils.getNextCredit(conversionRates, 150), 200);
    expect(RedeemRewardUtils.getNextCredit(conversionRates, 250), 250);
  });

  test('Test getPrevCredit', () {
    expect(RedeemRewardUtils.getPrevCredit([], 100), 100);

    final conversionRates = [
      ConversionRates(credit: 50),
      ConversionRates(credit: 100),
      ConversionRates(credit: 200),
    ];

    expect(RedeemRewardUtils.getPrevCredit(conversionRates, 75), 50);
    expect(RedeemRewardUtils.getPrevCredit(conversionRates, 150), 100);

    expect(RedeemRewardUtils.getPrevCredit(conversionRates, 250), 200);
  });
}
