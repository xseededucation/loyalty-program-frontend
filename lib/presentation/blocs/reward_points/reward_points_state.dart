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
  final Product? product;
  final String? message;

  const RewardPointsSuccess({this.pageInformation,this.message,this.product});

  RewardPointsSuccess copyWith({PageInformation? pageInformation, String? message, Product? product}) =>
      RewardPointsSuccess(
          pageInformation: pageInformation ?? this.pageInformation,    
          product: product ?? this.product,      
          message:  message ?? this.message
          );

  @override
  List<Object> get props => [pageInformation ?? {},product!,message!];

  @override
  String toString() => 'RewardPointsSuccess';
}

class RewardPointsFailure extends RewardPointsState {
  const RewardPointsFailure(this.error);

  final String error;

  @override
  List<Object> get props => [error];
}
