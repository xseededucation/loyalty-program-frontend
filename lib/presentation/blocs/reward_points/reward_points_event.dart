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

class ToggleRedeemScreen extends RewardPointsEvent {
  final bool setToOpen;

  ToggleRedeemScreen(this.setToOpen);
  @override
  List<Object?> get props => [setToOpen];
}

class ChangeSliderPoints extends RewardPointsEvent {
  final double points;

  ChangeSliderPoints(this.points);
  @override
  List<Object?> get props => [points];
}

class ChangeTabIndex extends RewardPointsEvent {
  final int index;

  ChangeTabIndex(this.index);
  @override
  List<Object?> get props => [index];
}

class SetHeaderTextVisible extends RewardPointsEvent {
  final bool setVisible;

  SetHeaderTextVisible(this.setVisible);
  @override
  List<Object?> get props => [setVisible];
}

class UpdateOptForUser extends RewardPointsEvent {
  final String status;

  UpdateOptForUser(this.status);
  @override
  List<Object?> get props => [status];
}
