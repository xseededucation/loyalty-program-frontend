import 'package:equatable/equatable.dart';

abstract class RewardPointsEvent extends Equatable {}

class CanAccessLoyaltyProgram extends RewardPointsEvent {
  @override
  List<Object?> get props => [];
}

class FetchPageInformationEvent extends RewardPointsEvent {
  @override
  List<Object?> get props => [];
}

class TriggerPaymentEvent extends RewardPointsEvent {
  final int creditToRedeem;
  final String productId;

  TriggerPaymentEvent(this.creditToRedeem, this.productId);
  @override
  List<Object?> get props => [creditToRedeem, productId];
}
