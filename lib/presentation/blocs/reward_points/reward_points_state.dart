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
  final bool? isRedeemPageOpen;

  const RewardPointsSuccess({this.pageInformation,this.message,this.products,this.isRedeemPageOpen});

  RewardPointsSuccess copyWith({PageInformation? pageInformation, String? message, List<ProductList>? products, bool? isRedeemPageOpen}) =>
      RewardPointsSuccess(
          pageInformation: pageInformation ?? this.pageInformation,    
          products: products ?? this.products,                     
          message:  message ?? this.message,
          isRedeemPageOpen: isRedeemPageOpen ?? this.isRedeemPageOpen, 
          );

  @override
  List<Object> get props => [pageInformation ?? {},products!,message!,isRedeemPageOpen!];

  @override
  String toString() => 'RewardPointsSuccess';
}

class RewardPointsFailure extends RewardPointsState {
  const RewardPointsFailure(this.error);

  final String error;

  @override
  List<Object> get props => [error];
}
