import 'package:loyalty_program_frontend/data/networking/api_base_helper.dart';

class RewardPointRepository {
  ApiBaseHelper apiBaseHelper = ApiBaseHelper();

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

  makePayment(int creditToRedeem, String productId) async {
    var url = "makePayment";
    // var response = await apiBaseHelper
    //     .post(url, {"creditToRedeem": creditToRedeem, "productId": productId});
    return {
      "status": "success",
      "message":
          "Your gift card has been sent to following Mobile: +919068408460 Email: mohin.ahmad@xseededucation.com",
      "data": {}
    };
  }
}
