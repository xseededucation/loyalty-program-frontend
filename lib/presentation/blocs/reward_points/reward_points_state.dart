import 'package:equatable/equatable.dart';
import 'package:loyalty_program_frontend/domain/models/page_information.dart';

abstract class RewardPointsState extends Equatable {
  const RewardPointsState();

  @override
  List<Object> get props => [];
}

class RewardPointsInitial extends RewardPointsState {}

class RewardPointsInProgress extends RewardPointsState {}

class RewardPointsSuccess extends RewardPointsState {
  final PageInformation? pageInformation;
  final String? message;
  final bool? isRedeemPageOpen;

  const RewardPointsSuccess(
      {this.pageInformation, this.message, this.isRedeemPageOpen});

  RewardPointsSuccess copyWith(
          {PageInformation? pageInformation,
          String? message,
          bool? isRedeemPageOpen}) =>
      RewardPointsSuccess(
          pageInformation: pageInformation ?? this.pageInformation,
          message: message ?? this.message,
          isRedeemPageOpen: isRedeemPageOpen ?? this.isRedeemPageOpen);

  @override
  List<Object> get props => [pageInformation ?? {}, isRedeemPageOpen ?? false];

  @override
  String toString() => 'RewardPointsSuccess';
}

class RewardPointsFailure extends RewardPointsState {
  const RewardPointsFailure(this.error);

  final String error;

  @override
  List<Object> get props => [error];
}
