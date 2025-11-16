import 'package:engzly/features/home/data/models/offers/offers_response_model.dart';
import 'package:equatable/equatable.dart';

abstract class OffersState extends Equatable {
  @override
  List<Object?> get props => [];
}

class OffersInitial extends OffersState {}

class OffersLoading extends OffersState {}

class OffersSuccess extends OffersState {
  final List<OffersResponseModel> offers;

  OffersSuccess(this.offers);

  @override
  List<Object?> get props => [offers];
}

class OffersError extends OffersState {
  final String message;

  OffersError(this.message);

  @override
  List<Object?> get props => [message];
}
