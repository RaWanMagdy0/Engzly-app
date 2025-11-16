
import 'package:engzly/features/home/data/models/offers/offers_response_model.dart';
import 'package:engzly/features/home/data/models/service/service_response_model.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class OffersLoading extends HomeState {}
class ServiceLoading extends HomeState {}

class HomeOffersSuccess extends HomeState {
  final List<OffersResponseModel> offers;

  HomeOffersSuccess(this.offers);
}

class HomeServicesSuccess extends HomeState {
  final List<ServiceResponseModel> services;

  HomeServicesSuccess(this.services);
}

class OffersError extends HomeState {
  final String error;
  OffersError(this.error);
}
class ServiceError extends HomeState {
  final String error;
  ServiceError(this.error);
}
