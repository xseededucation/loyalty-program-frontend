import 'package:flutter_test/flutter_test.dart';
import 'package:loyalty_program_frontend/domain/models/page_information.dart';
import 'package:loyalty_program_frontend/presentation/utils/helpers/has_user_achieved_any_milestone.dart';

void main() {
  test('Test hasUserAchievedAnyMileStone', () {
    final information1 =
        PageInformation(conversionRates: [], currentCredit: 100);
    expect(hasUserAchievedAnyMileStone(information1), false);

    final conversionRate1 = ConversionRates(credit: 200);
    final information2 =
        PageInformation(conversionRates: [conversionRate1], currentCredit: 100);
    expect(hasUserAchievedAnyMileStone(information2), false);

    final conversionRate2 = ConversionRates(credit: 50);
    final information3 =
        PageInformation(conversionRates: [conversionRate2], currentCredit: 100);
    expect(hasUserAchievedAnyMileStone(information3), true);

    final conversionRate3 = ConversionRates(credit: 200);
    final information4 = PageInformation(
        conversionRates: [conversionRate1, conversionRate2, conversionRate3],
        currentCredit: 100);
    expect(hasUserAchievedAnyMileStone(information4), true);

    final information5 = PageInformation(
        conversionRates: [conversionRate1, conversionRate3],
        currentCredit: 100);
    expect(hasUserAchievedAnyMileStone(information5), false);
  });
}
