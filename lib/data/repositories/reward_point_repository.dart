import 'package:loyalty_program_frontend/data/networking/api_base_helper.dart';
import 'package:http/http.dart' as http;

class RewardPointRepository {
  ApiBaseHelper apiBaseHelper = ApiBaseHelper(http.Client());

  checkCanAccessLoyaltyProgram() async {
    var url = "canAccessLoyaltyProgram";
    var response = await apiBaseHelper.get(url);
    return response;
  }

  fetchPageInformation() async {
    var url = "pageInformation";
    var response = await apiBaseHelper.get(url);
    return response;
  }

  Future makePayment(int creditToRedeem, String productId) async {
    var url = "makePayment";
    var response = await apiBaseHelper
        .post(url, {"creditToRedeem": creditToRedeem, "productId": productId});
    return response;
  }

  updateUserActivity(String activity) async {
    var url = "updateUserActivity";
    var response = await apiBaseHelper.post(url, {"activityType": activity});
    return response;
  }
}
