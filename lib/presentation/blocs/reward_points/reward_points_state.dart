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
  final double? pointsToShow;
  final Map<String,dynamic>? changeTabIndex;

  const RewardPointsSuccess(
      {this.pageInformation,
      this.eventType,
      this.products,
      this.isRedeemPageOpen,
      this.isEligibleForReward,
      this.pointsToShow,
      this.changeTabIndex
      });

  RewardPointsSuccess copyWith(
          {PageInformation? pageInformation,
          String? eventType,
          List<ProductList>? products,
          bool? isRedeemPageOpen,
          double? pointsToShow, 
          bool? isEligibleForReward = false,
          Map<String,dynamic>? changeTabIndex
          }) =>
      RewardPointsSuccess(
          pageInformation: pageInformation ?? this.pageInformation,
          products: products ?? this.products,
          eventType: eventType ?? this.eventType,
          isRedeemPageOpen: isRedeemPageOpen ?? this.isRedeemPageOpen,
          isEligibleForReward: isEligibleForReward ?? this.isEligibleForReward,
          pointsToShow: pointsToShow ?? this.pointsToShow,
          changeTabIndex:  changeTabIndex ?? this.changeTabIndex
          );

  @override
  List<Object> get props =>
      [pageInformation ?? {}, products!, isRedeemPageOpen!, pointsToShow ?? 0, isEligibleForReward ?? false];

  @override
  String toString() => 'RewardPointsSuccess';
}

class RewardPointsFailure extends RewardPointsState {
  final bool isEligibleForReward;
  const RewardPointsFailure(this.error,{this.isEligibleForReward = false,});

  final String error;

  @override
  List<Object> get props => [error];
}
