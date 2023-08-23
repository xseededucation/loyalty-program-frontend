import 'package:flutter_test/flutter_test.dart';
import 'package:loyalty_program_frontend/domain/models/page_information.dart';
import 'package:loyalty_program_frontend/loyalty_program_frontend.dart';

void main() {
  group('RewardPointsState Tests', () {
    test('Test RewardPointsSuccess state copyWith', () {
      final initialPageInfo = PageInformation.fromJson({});

      final newState = RewardPointsSuccess(pageInformation: initialPageInfo);

      final updatedPageInfo = PageInformation.fromJson({
        "conversionRates": [
          {
            "credit": 3000,
            "denomination": 500,
            "sequenceNo": 1,
            "toolTipText": "next level 6000 points"
          },
          {
            "credit": 6000,
            "denomination": 1000,
            "sequenceNo": 2,
            "toolTipText": "next level 10000 points"
          },
          {
            "credit": 10000,
            "denomination": 1500,
            "sequenceNo": 3,
            "toolTipText": "next level 15000 points"
          },
          {
            "credit": 15000,
            "denomination": 2500,
            "sequenceNo": 4,
            "toolTipText": "No more levels"
          }
        ],
        "currentCredit": 1500,
        "eventToCreditMap": [
          {"event": "APP_OPEN", "creditGiven": 50, "timeInMins": 0},
          {"event": "TIME_BOUND", "creditGiven": 15, "timeInMins": 15},
          {"event": "SWIPE", "creditGiven": 10, "timeInMins": 0}
        ],
        "pageDetails": [
          {"text": "data", "textToCredit": "", "entityType": "Terms"},
          {
            "text": "Earn More",
            "textToCredit": [
              {"text": "sample text1", "credit": 2, "subText": "sample text1"},
              {"text": "sample text2", "credit": 5, "subText": "sample text2"}
            ],
            "entityType": "EarnMore"
          }
        ],
        "debitActivity": {}
      });

      final updatedState = newState.copyWith(pageInformation: updatedPageInfo);

      expect(updatedState.pageInformation, updatedPageInfo);
      expect(updatedState.message, null);
    });

    test('Test RewardPointsFailure state', () {
      const errorMessage = 'Something went wrong';
      const failureState = RewardPointsFailure(errorMessage);

      expect(failureState.error, errorMessage);
    });
  });
}
