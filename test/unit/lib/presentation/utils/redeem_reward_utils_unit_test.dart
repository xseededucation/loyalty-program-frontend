import 'package:flutter_test/flutter_test.dart';
import '../../../../../lib/presentation/utils/helpers/redeem_reward_utils.dart';


void main() {
  group('Redeem Reward Functions Tests', () {
    test('findNearestLastCredit', () {
      final data = {
        "conversionRates": [
          {"credit": 3000, "denomination": 500},
          {"credit": 6000, "denomination": 1000},
          {"credit": 10000, "denomination": 1500},
          {"credit": 15000, "denomination": 2500}
        ],
        "currentCredit": 12500,
      };
      expect(RedeemRewardUtils.findNearestLastCredit(data), 10000);
    });

    test('findDenomination', () {
      final conversionRates = [
        {"credit": 3000, "denomination": 500},
        {"credit": 6000, "denomination": 1000},
        {"credit": 10000, "denomination": 1500},
        {"credit": 15000, "denomination": 2500}
      ];
      expect(RedeemRewardUtils.findDenomination(conversionRates, 7000), 1000);
    });

    test('getNextCredit', () {
      final conversionRates = [
        {"credit": 3000, "denomination": 500},
        {"credit": 6000, "denomination": 1000},
        {"credit": 10000, "denomination": 1500},
        {"credit": 15000, "denomination": 2500}
      ];
      expect(RedeemRewardUtils.getNextCredit(conversionRates, 7000), 10000);
    });

    test('getPrevCredit', () {
      final conversionRates = [
        {"credit": 3000, "denomination": 500},
        {"credit": 6000, "denomination": 1000},
        {"credit": 10000, "denomination": 1500},
        {"credit": 15000, "denomination": 2500}
      ];
      expect(RedeemRewardUtils.getPrevCredit(conversionRates, 9000), 6000);
    });
  });
}

