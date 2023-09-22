// utility_functions.dart

import 'package:loyalty_program_frontend/domain/models/page_information.dart';

class RedeemRewardUtils {
  // This  will help is nearest credit less than current credit
  static int findNearestLastCredit(
      List<ConversionRates> conversionRates, int currentCredit) {
    int nearestLastCredit = 0;

    for (var rate in conversionRates) {
      int credit = rate.credit!;
      if (credit <= currentCredit) {
        nearestLastCredit = credit;
      } else {
        break;
      }
    }

    return nearestLastCredit;
  }

  static int findDenomination(
      List<ConversionRates> conversionRates, int credit) {
    int maxDenomination = 0;
    for (var rate in conversionRates) {
      if (credit >= rate.credit! && rate.credit! > maxDenomination) {
        maxDenomination = rate.denomination!;
      }
    }
    return maxDenomination;
  }

//Function will help in getting the next credit number
  static int getNextCredit(
      List<ConversionRates> conversionRates, int currentCredit) {
    for (int i = 0; i < conversionRates.length; i++) {
      if (conversionRates[i].credit! > currentCredit) {
        return conversionRates[i].credit!;
      }
    }
    return currentCredit;
  }

//Function will help in getting the previous credit number
  static int getPrevCredit(
      List<ConversionRates> conversionRates, int currentCredit) {
    for (int i = conversionRates.length - 1; i >= 0; i--) {
      if (conversionRates[i].credit! < currentCredit) {
        return conversionRates[i].credit!;
      }
    }
    return currentCredit;
  }
}
