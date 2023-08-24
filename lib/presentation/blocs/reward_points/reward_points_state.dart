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
  final String? message;

  const RewardPointsSuccess({this.pageInformation,this.message,this.products});

  RewardPointsSuccess copyWith({PageInformation? pageInformation, String? message, List<ProductList>? products}) =>
      RewardPointsSuccess(
          pageInformation: pageInformation ?? this.pageInformation,    
          products: products ?? this.products,      
          message:  message ?? this.message
          );

  @override
  List<Object> get props => [pageInformation ?? {},products!,message!];

  @override
  String toString() => 'RewardPointsSuccess';
}

class RewardPointsFailure extends RewardPointsState {
  const RewardPointsFailure(this.error);

  final String error;

  @override
  List<Object> get props => [error];
}
