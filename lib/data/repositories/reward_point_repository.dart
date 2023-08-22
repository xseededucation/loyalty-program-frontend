import 'package:loyalty_program_frontend/data/networking/api_base_helper.dart';

class RewardPointRepository {
  ApiBaseHelper apiBaseHelper = ApiBaseHelper();

  checkCanAccessLoyaltyProgram() async {
    var url = "canAccessLoyaltyProgram";
    var response = await apiBaseHelper.get(url);
    return response;
  }

  fetchPageInformation() async {
    var data = {
      "status": "success",
      "data": {
        "conversionRates": [
          {"credit": 3000, "denomination": 500},
          {"credit": 6000, "denomination": 1000},
          {"credit": 10000, "denomination": 1500},
          {"credit": 15000, "denomination": 2500}
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
            "text": "",
            "textToCredit": [
              {"text": "sample text1", "credit": 2},
              {"text": "sample text2", "credit": 5}
            ],
            "entityType": "EarnMore"
          }
        ]
      }
    };
    await Future.delayed(Duration(seconds: 3));
    // var url = "pageInformation";
    // var response = await apiBaseHelper.get(url);
    return data;
  }
}
