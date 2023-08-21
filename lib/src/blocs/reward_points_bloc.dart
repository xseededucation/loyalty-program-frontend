import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loyalty_program_frontend/src/blocs/reward_points_event.dart';
import 'package:loyalty_program_frontend/src/blocs/reward_points_state.dart';
import 'package:loyalty_program_frontend/src/repositories/reward_point_repository.dart';

class RewardPointsBloc extends Bloc<RewardPointsEvent, RewardPointsState> {
  RewardPointRepository rewardPointRepository;

  RewardPointsBloc({required this.rewardPointRepository})
      : super(RewardPointsSuccess()) {
    on<CanAccessLoyaltyProgram>(_mapCanAccessLoyaltyProgram);
  }

  RewardPointsSuccess rewardPointsSuccess = RewardPointsSuccess();

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
}
