import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loyalty_program_frontend/data/repositories/reward_point_repository.dart';
import 'package:loyalty_program_frontend/domain/models/common.dart';
import 'package:loyalty_program_frontend/domain/models/page_information.dart';
import 'package:loyalty_program_frontend/domain/models/product.dart';
import 'package:loyalty_program_frontend/presentation/blocs/reward_points/reward_points_event.dart';
import 'package:loyalty_program_frontend/presentation/blocs/reward_points/reward_points_state.dart';

class RewardPointsBloc extends Bloc<RewardPointsEvent, RewardPointsState> {
  RewardPointRepository rewardPointRepository;

  RewardPointsBloc({required this.rewardPointRepository})
      : super(RewardPointsInitial()) {
    on<CanAccessLoyaltyProgram>(_mapCanAccessLoyaltyProgram);
    on<FetchPageInformationEvent>(_mapFetchPageInformation);
    on<TriggerPaymentEvent>(_mapTriggerPayment);
  }

  RewardPointsSuccess rewardPointsSuccess = const RewardPointsSuccess();

  void _mapCanAccessLoyaltyProgram(
      CanAccessLoyaltyProgram event, Emitter<RewardPointsState> emit) async {
    try {
      emit(RewardPointsInProgress());
      var response = await rewardPointRepository.checkCanAccessLoyaltyProgram();
      if (response["status"] == "success") {
        // rewardPointsSuccess = rewardPointsSuccess.copyWith(
        //     product: Product.fromJson(response["data"])!);
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
      var response = await rewardPointRepository.fetchPageInformation();

      Common<PageInformation> commonResponse = Common<PageInformation>.fromJson(
        response,
        (json) => PageInformation.fromJson(json),
      );

      if (commonResponse.data != null) {
        rewardPointsSuccess =
            rewardPointsSuccess.copyWith(pageInformation: commonResponse.data!);
      }
      emit(rewardPointsSuccess);
    } catch (e) {
      print("RewardPointsFailure : $e");
      emit(RewardPointsFailure("$e"));
    }
  }

  void _mapTriggerPayment(
      TriggerPaymentEvent event, Emitter<RewardPointsState> emit) async {
    try {
      emit(RewardPointsInProgress());
      var result = await rewardPointRepository.makePayment(
          event.creditToRedeem, event.productId);
      rewardPointsSuccess = rewardPointsSuccess.copyWith(
        message: result['message'],
      );
      emit(rewardPointsSuccess);
    } catch (e) {
      emit(RewardPointsFailure("$e"));
    }
  }
}
