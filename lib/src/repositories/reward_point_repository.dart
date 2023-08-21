import 'package:loyalty_program_frontend/src/networking/api_base_helper.dart';

class RewardPointRepository {
  ApiBaseHelper apiBaseHelper = ApiBaseHelper();

  checkCanAccessLoyaltyProgram() async {
    var url = "canAccessLoyaltyProgram";
    var response = await apiBaseHelper.get(url);
    return response;
  }
}
