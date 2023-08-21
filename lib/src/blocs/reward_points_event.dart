import 'package:equatable/equatable.dart';

abstract class RewardPointsEvent extends Equatable {}

class CanAccessLoyaltyProgram extends RewardPointsEvent {
  @override
  List<Object?> get props => throw UnimplementedError();
}
