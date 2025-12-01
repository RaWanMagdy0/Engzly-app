
import 'package:engzly/features/services/cleaning/data/models/response/cleaning_response_model.dart/cleaning_booking_response.dart';
import 'package:engzly/features/services/cleaning/data/models/response/house_size_model.dart/house_size_model.dart';
import 'package:engzly/features/services/cleaning/data/models/response/location_response/location_model.dart';
import 'package:engzly/features/services/cleaning/data/models/response/promo_code.dart/promo_code_response.dart';

abstract class CleaningStates {}


class CleaningInitial extends CleaningStates {}

///     Selections
class CleaningHouseSizeSelected extends CleaningStates {
  final HouseSizeModel selected;
  CleaningHouseSizeSelected(this.selected);
}

class CleaningBookingServiceSelected extends CleaningStates {
  final int serviceId;
  CleaningBookingServiceSelected({required this.serviceId});
}

class CleaningDateSelected extends CleaningStates {
  final DateTime date;
  CleaningDateSelected(this.date);
}

class CleaningLocationSelected extends CleaningStates {
  final String address;
  CleaningLocationSelected({required this.address});
}

class CleaningUpdated extends CleaningStates {}


///     Checkout States

class CleaningCheckOutOrderLoading extends CleaningStates {}

class CleaningCheckOutOrderSuccess extends CleaningStates {
  final List<CleaningBookingResponse> booking;
  CleaningCheckOutOrderSuccess(this.booking);
}

class CleaningCheckOutOrderError extends CleaningStates {
  final String message;
  CleaningCheckOutOrderError(this.message);
}


///     House Size States

class GetHouseSizeLoading extends CleaningStates {}

class GetHouseSizeSuccess extends CleaningStates {
  final List<HouseSizeModel> houseSizes;
  GetHouseSizeSuccess(this.houseSizes);
}

class GetHouseSizeError extends CleaningStates {
  final String error;
  GetHouseSizeError(this.error);
}


///     Promo Code States

class CleaningPromoCodeLoading extends CleaningStates {}

class CleaningPromoCodeSuccess extends CleaningStates {
  final PromoCodeResponse promoCode;
  CleaningPromoCodeSuccess(this.promoCode);
}

class CleaningPromoCodeError extends CleaningStates {
  final String error;
  CleaningPromoCodeError(this.error);
}

class CleaningPromoCodeRemoved extends CleaningStates {}

///     Locations States

class CleaningLocationsLoading extends CleaningStates {}

class CleaningLocationsSuccess extends CleaningStates {
  final List<LocationModel> locations;
  CleaningLocationsSuccess(this.locations);
}

class CleaningLocationsError extends CleaningStates {
  final String message;
  CleaningLocationsError(this.message);
}
