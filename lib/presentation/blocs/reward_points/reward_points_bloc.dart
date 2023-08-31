import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loyalty_program_frontend/data/repositories/reward_point_repository.dart';
import 'package:loyalty_program_frontend/domain/models/common.dart';
import 'package:loyalty_program_frontend/domain/models/page_information.dart';
import 'package:loyalty_program_frontend/domain/models/product.dart';
import 'package:loyalty_program_frontend/presentation/blocs/reward_points/reward_points_event.dart';
import 'package:loyalty_program_frontend/presentation/blocs/reward_points/reward_points_state.dart';
import 'package:loyalty_program_frontend/presentation/utils/constants/constant.dart';
import 'package:get_it/get_it.dart';
import 'package:loyalty_program_frontend/presentation/utils/helpers/loyalty_program_event.dart';

class RewardPointsBloc extends Bloc<RewardPointsEvent, RewardPointsState> {
  RewardPointRepository rewardPointRepository;

  RewardPointsBloc({required this.rewardPointRepository})
      : super(RewardPointsInitial()) {
    on<CanAccessLoyaltyProgram>(_mapCanAccessLoyaltyProgram);
    on<FetchPageInformationEvent>(_mapFetchPageInformation);
    on<TriggerPaymentEvent>(_mapTriggerPayment);
    on<ToggleRedeemScreen>(_mapToggleRedeemScreen);
    on<ChangeSliderPoints>(_mapChangeSliderPoint);
    on<ChangeTabIndex>(_mapChangeTabIndex);
  }

  RewardPointsSuccess rewardPointsSuccess = RewardPointsSuccess(
      products: const [],
      pageInformation: PageInformation(),
      isRedeemPageOpen: false,
      isEligibleForReward: false,
      changeTabIndex: const {});

  void _mapCanAccessLoyaltyProgram(
      CanAccessLoyaltyProgram event, Emitter<RewardPointsState> emit) async {
    try {
      if (rewardPointsSuccess.products != null &&
          rewardPointsSuccess.products!.isNotEmpty) {
        emit(RewardPointsInitial());
        emit(rewardPointsSuccess);
        return;
      }
      emit(RewardPointsInProgress());
      var response = await rewardPointRepository.checkCanAccessLoyaltyProgram();
      if (response["status"] == "success") {
        List<ProductList> products = [];
        response["data"].forEach((product) {
          products.add(ProductList.fromJson(product));
        });
        rewardPointsSuccess = rewardPointsSuccess.copyWith(
            products: products, isEligibleForReward: true);
        return emit(rewardPointsSuccess);
      } else {
        rewardPointsSuccess = rewardPointsSuccess
            .copyWith(products: [], isEligibleForReward: false);
        emit(rewardPointsSuccess);
      }
    } catch (error) {
      rewardPointsSuccess =
          rewardPointsSuccess.copyWith(products: [], isEligibleForReward: true);
      return emit(rewardPointsSuccess);
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
        final EventToCreditMap timeBoundEvent =
            commonResponse.data!.eventToCreditMap!.firstWhere(
                (EventToCreditMap element) => element.event == TIME_BOUND);

        GetIt.I<LoyaltyProgramEvent>().stayedInApp(timeBoundEvent.timeInMins!);

        rewardPointsSuccess = rewardPointsSuccess.copyWith(
            isRedeemPageOpen: false, pageInformation: commonResponse.data!);
        rewardPointsSuccess = rewardPointsSuccess.copyWith(
          pointsToShow:
              rewardPointsSuccess.pageInformation!.currentCredit!.toDouble(),
          eventType: "",
        );
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
      rewardPointsSuccess =
          rewardPointsSuccess.copyWith(eventType: "makePayment");
      emit(rewardPointsSuccess);
      var response = await rewardPointRepository.makePayment(
          event.creditToRedeem, event.productId);
      if (response["status"] == "success") {
        rewardPointsSuccess =
            rewardPointsSuccess.copyWith(eventType: "makePayment");
        emit(rewardPointsSuccess);
        add(FetchPageInformationEvent());
      } else {
        emit(RewardPointsFailure("${response["message"]}"));
      }
    } catch (e) {
      emit(RewardPointsFailure("$e"));
    }
  }

  void _mapToggleRedeemScreen(
      ToggleRedeemScreen event, Emitter<RewardPointsState> emit) async {
    emit(RewardPointsInProgress());
    if (!event.setToOpen) {
      rewardPointsSuccess = rewardPointsSuccess
          .copyWith(isRedeemPageOpen: false, eventType: "", changeTabIndex: {});
    } else {
      rewardPointsSuccess = rewardPointsSuccess
          .copyWith(isRedeemPageOpen: true, eventType: "", changeTabIndex: {});
    }
    emit(rewardPointsSuccess);
  }

  void _mapChangeSliderPoint(
      ChangeSliderPoints event, Emitter<RewardPointsState> emit) {
    emit(RewardPointsInProgress());
    rewardPointsSuccess =
        rewardPointsSuccess.copyWith(pointsToShow: event.points);
    emit(rewardPointsSuccess);
  }

  void _mapChangeTabIndex(
      ChangeTabIndex event, Emitter<RewardPointsState> emit) {
    emit(RewardPointsInProgress());
    rewardPointsSuccess =
        rewardPointsSuccess.copyWith(changeTabIndex: {"index": event.index});
    emit(rewardPointsSuccess);
    rewardPointsSuccess = rewardPointsSuccess.copyWith(changeTabIndex: {});
    emit(rewardPointsSuccess);
    if (event.index == 0) {
      Future.delayed(const Duration(milliseconds: 900), () {
        add(ToggleRedeemScreen(true));
      });
    }
  }
}
