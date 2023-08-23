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
  final PageInformationModel pageInformation;
  final bool isRedeemPageOpen;

  const RewardPointsSuccess(
      {required this.pageInformation, required this.isRedeemPageOpen});

  RewardPointsSuccess copyWith(
          {PageInformationModel? pageInformation, bool? isRedeemPageOpen}) =>
      RewardPointsSuccess(
          pageInformation: pageInformation ?? this.pageInformation,
          isRedeemPageOpen: isRedeemPageOpen ?? this.isRedeemPageOpen);

  @override
  List<Object> get props => [pageInformation, isRedeemPageOpen];

  @override
  String toString() => 'RewardPointsSuccess';
}

class RewardPointsFailure extends RewardPointsState {
  const RewardPointsFailure(this.error);

  final String error;

  @override
  List<Object> get props => [error];
}
