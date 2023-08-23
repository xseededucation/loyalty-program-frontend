import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loyalty_program_frontend/data/repositories/reward_point_repository.dart';
import 'package:loyalty_program_frontend/domain/models/page_information.dart';
import 'package:loyalty_program_frontend/presentation/blocs/reward_points/reward_points_event.dart';
import 'package:loyalty_program_frontend/presentation/blocs/reward_points/reward_points_state.dart';

class RewardPointsBloc extends Bloc<RewardPointsEvent, RewardPointsState> {
  RewardPointRepository rewardPointRepository;

  RewardPointsBloc({required this.rewardPointRepository})
      : super(RewardPointsInitial()) {
    on<CanAccessLoyaltyProgram>(_mapCanAccessLoyaltyProgram);
    on<FetchPageInformationEvent>(_mapFetchPageInformation);
    on<ToggleRedeemPageEvent>(_mapToggleRedeemPage);
  }

  RewardPointsSuccess rewardPointsSuccess = RewardPointsSuccess(
      pageInformation: PageInformationModel(), isRedeemPageOpen: false);

  void _mapCanAccessLoyaltyProgram(
      CanAccessLoyaltyProgram event, Emitter<RewardPointsState> emit) async {
    try {
      emit(RewardPointsInProgress());
      var response = await rewardPointRepository.checkCanAccessLoyaltyProgram();
      if (response["status"] == true) {
        return emit(rewardPointsSuccess);
      } else {
        emit(RewardPointsFailure("${response["message"]}"));
      }
    } catch (error) {
      emit(RewardPointsFailure("$error"));
    }
  }

  void _mapFetchPageInformation(
      FetchPageInformationEvent event, Emitter<RewardPointsState> emit) async {
    try {
      emit(RewardPointsInProgress());
      var result = await rewardPointRepository.fetchPageInformation();
      rewardPointsSuccess = rewardPointsSuccess.copyWith(
          pageInformation: PageInformationModel.fromJson(result));
      emit(rewardPointsSuccess);
    } catch (e) {
      emit(RewardPointsFailure("$e"));
    }
  }

  void _mapToggleRedeemPage(
      ToggleRedeemPageEvent event, Emitter<RewardPointsState> emit) {
    bool isAnyMileStoneAchieved = false;
    List<ConversionRates> list =
        rewardPointsSuccess.pageInformation.data!.conversionRates!;
    double currentPoints =
        rewardPointsSuccess.pageInformation.data!.currentCredit!.toDouble();
    for (int i = 0; i < list.length; i++) {
      if (list[i].credit != 0 && list[i].credit! >= currentPoints) {
        isAnyMileStoneAchieved = true;
        break;
      }
    }
    if (isAnyMileStoneAchieved) {
      rewardPointsSuccess =
          rewardPointsSuccess.copyWith(isRedeemPageOpen: true);
    }
    emit(rewardPointsSuccess);
  }
}
