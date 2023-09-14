import 'package:equatable/equatable.dart';
import 'package:loyalty_program_frontend/domain/models/page_information.dart';
import 'package:loyalty_program_frontend/domain/models/product.dart';

abstract class RewardPointsState extends Equatable {
  const RewardPointsState();

  @override
  List<Object> get props => [];
}

class RewardPointsInitial extends RewardPointsState {}

class RewardPointsInProgress extends RewardPointsState {}

class RewardPointsSuccess extends RewardPointsState {
  final PageInformation? pageInformation;
  final List<ProductList>? products;
  final String? eventType;
  final bool? isRedeemPageOpen;
  final bool? isEligibleForReward;
  final bool? isHeaderTextVisible;
  final double? pointsToShow;
  final String? optInStatus;
  final Map<String, dynamic>? changeTabIndex;

  const RewardPointsSuccess(
      {this.pageInformation,
      this.eventType,
      this.products,
      this.isRedeemPageOpen,
      this.isEligibleForReward,
      this.isHeaderTextVisible,
      this.pointsToShow,
      this.optInStatus,
      this.changeTabIndex});

  RewardPointsSuccess copyWith(
          {PageInformation? pageInformation,
          String? eventType,
          List<ProductList>? products,
          bool? isRedeemPageOpen,
          bool? isHeaderTextVisible,
          double? pointsToShow,
          String? optInStatus,
          bool? isEligibleForReward = false,
          Map<String, dynamic>? changeTabIndex}) =>
      RewardPointsSuccess(
          isHeaderTextVisible: isHeaderTextVisible ?? this.isHeaderTextVisible,
          pageInformation: pageInformation ?? this.pageInformation,
          products: products ?? this.products,
          eventType: eventType ?? this.eventType,
          isRedeemPageOpen: isRedeemPageOpen ?? this.isRedeemPageOpen,
          isEligibleForReward: isEligibleForReward ?? this.isEligibleForReward,
          pointsToShow: pointsToShow ?? this.pointsToShow,
          optInStatus: optInStatus ?? this.optInStatus,
          changeTabIndex: changeTabIndex ?? this.changeTabIndex);

  @override
  List<Object> get props => [
        pageInformation ?? {},
        products!,
        isRedeemPageOpen!,
        pointsToShow ?? 0,
        isEligibleForReward ?? false,
        isHeaderTextVisible ?? true
      ];

  @override
  String toString() => 'RewardPointsSuccess';
}

class RewardPointsFailure extends RewardPointsState {
  final bool isEligibleForReward;
  const RewardPointsFailure(
    this.error, {
    this.isEligibleForReward = false,
  });

  final String error;

  @override
  List<Object> get props => [error];
}
