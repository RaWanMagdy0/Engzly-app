
import 'package:engzly/features/home/data/models/offers/offers_response_model.dart';
import 'package:engzly/features/home/data/models/service/service_response_model.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeDataSuccess extends HomeState {
  final List<OffersResponseModel> offers;
  final List<ServiceResponseModel> services;

  HomeDataSuccess(this.offers, this.services);
}

class HomeError extends HomeState {
  final String error;
  HomeError(this.error);
}
