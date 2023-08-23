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

  const RewardPointsSuccess({this.pageInformation,this.message});

  RewardPointsSuccess copyWith({PageInformation? pageInformation, String? message}) =>
      RewardPointsSuccess(
          pageInformation: pageInformation ?? this.pageInformation,          
          message:  message ?? this.message
          );

  @override
  List<Object> get props => [pageInformation ?? {}];

  @override
  String toString() => 'RewardPointsSuccess';
}

class RewardPointsFailure extends RewardPointsState {
  const RewardPointsFailure(this.error);

  final String error;

  @override
  List<Object> get props => [error];
}
