import 'package:engzly/features/profile/data/models/get_address/location_model.dart';
import 'package:engzly/features/services/house_shifting/data/models/promo_code_response.dart';
import 'package:engzly/features/services/house_shifting/data/models/vehicle_model.dart';
import 'package:engzly/features/services/vehicle/data/models/vehicle_booking_response.dart';

abstract class VehicleStates {}

class VehicleInitial extends VehicleStates {}




class GetVehicleVehiclesLoading extends VehicleStates {}

class GetVehicleVehiclesSuccess extends VehicleStates {
  final List<VehicleModel> vehicles;
  GetVehicleVehiclesSuccess(this.vehicles);
}

class GetVehicleVehiclesError extends VehicleStates {
  final String error;
  GetVehicleVehiclesError(this.error);
}


class VehicleCheckOutOrderLoading extends VehicleStates {}

class VehicleCheckOutOrderSuccess extends VehicleStates {
  final List<VehicleBookingResponse> booking;
  VehicleCheckOutOrderSuccess(this.booking);
}

class VehicleCheckOutOrderError extends VehicleStates {
  final String message;
  VehicleCheckOutOrderError(this.message);
}

class VehiclePromoCodeLoading extends VehicleStates {}

class VehiclePromoCodeSuccess extends VehicleStates {
  final PromoCodeResponse promoCode;
  VehiclePromoCodeSuccess(this.promoCode);
}

class VehiclePromoCodeError extends VehicleStates {
  final String error;
  VehiclePromoCodeError(this.error);
}

class VehiclePromoCodeRemoved extends VehicleStates {}


class VehicleLocationsLoading extends VehicleStates {}

class VehicleLocationsSuccess extends VehicleStates {
  final List<LocationModel> locations;
  VehicleLocationsSuccess(this.locations);
}


class VehicleLocationsError extends VehicleStates {
  final String message;
  VehicleLocationsError(this.message);
}


class VehicleSelected extends VehicleStates {
  final VehicleModel vehicle;
  VehicleSelected(this.vehicle);
}

class VehicleBookingServiceSelected extends VehicleStates {
  final int serviceId;

  VehicleBookingServiceSelected( {
    required this.serviceId,
  });
}

class VehcileDateSelected extends VehicleStates {
  final DateTime date;
  VehcileDateSelected(this.date);
}

class VechicleLocationSelected extends VehicleStates {
  final String address;

  VechicleLocationSelected({
    required this.address,
  });
}

class VehcileUpdated extends VehicleStates {}
