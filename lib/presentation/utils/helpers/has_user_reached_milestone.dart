import 'package:loyalty_program_frontend/domain/models/page_information.dart';

bool hasUserReachedAnyMileStone(PageInformation information) {
  bool isAnyMileStoneAchieved = false;
  List<ConversionRates> list = information.conversionRates!;
  double currentPoints = information.currentCredit!.toDouble();
  for (int i = 0; i < list.length; i++) {
    if (list[i].credit != 0 && list[i].credit! >= currentPoints) {
      isAnyMileStoneAchieved = true;
      break;
    }
  }
  if (isAnyMileStoneAchieved) {
    isAnyMileStoneAchieved = true;
  }
  return isAnyMileStoneAchieved;
}
