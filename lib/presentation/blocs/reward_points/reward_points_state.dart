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
  final double? pointsToShow;

  const RewardPointsSuccess(
      {this.pageInformation,
      this.eventType,
      this.products,
      this.isRedeemPageOpen,
      this.pointsToShow});

  RewardPointsSuccess copyWith(
          {PageInformation? pageInformation,
          String? eventType,
          List<ProductList>? products,
          bool? isRedeemPageOpen,
          double? pointsToShow
          }) =>
      RewardPointsSuccess(
        pageInformation: pageInformation ?? this.pageInformation,
        products: products ?? this.products,
        eventType: eventType ?? this.eventType,
        isRedeemPageOpen: isRedeemPageOpen ?? this.isRedeemPageOpen,
        pointsToShow: pointsToShow??this.pointsToShow
      );

  @override
  List<Object> get props =>
      [pageInformation ?? {}, products!, isRedeemPageOpen!,pointsToShow!];

  @override
  String toString() => 'RewardPointsSuccess';
}

class RewardPointsFailure extends RewardPointsState {
  const RewardPointsFailure(this.error);

  final String error;

  @override
  List<Object> get props => [error];
}
