import 'package:engzly/features/profile/data/models/get_address/location_model.dart';
import 'package:engzly/features/services/house_shifting/data/models/house_size_model.dart';
import 'package:engzly/features/services/house_shifting/data/models/promo_code_response.dart';
import 'package:engzly/features/services/painting/data/models/get_colors_response_model.dart';
import 'package:engzly/features/services/painting/data/models/painting_booking_response.dart';

abstract class PaintingStates {}

class PaintingInitial extends PaintingStates {}

class PaintingHouseSizeSelected extends PaintingStates {
  final HouseSizeModel selected;
  PaintingHouseSizeSelected(this.selected);
}

class PaintingDateSelected extends PaintingStates {
  final DateTime date;
  PaintingDateSelected(this.date);
}
class PaintingBookingServiceSelected extends PaintingStates {
  final int serviceId;

  PaintingBookingServiceSelected( {
    required this.serviceId,
  });
}

class PaintingLocationSelected extends PaintingStates {
  final String address;

  PaintingLocationSelected({
    required this.address,
  });
}

class PaintingUpdated extends PaintingStates {}

class PaintingCheckOutOrderLoading extends PaintingStates {}

class PaintingCheckOutOrderSuccess extends PaintingStates {
  final List<PaintingBookingResponse> booking;
  PaintingCheckOutOrderSuccess(this.booking);
}

class PaintingCheckOutOrderError extends PaintingStates {
  final String message;
  PaintingCheckOutOrderError(this.message);
}

class GetPaintingHouseSizeLoading extends PaintingStates {}

class GetPaintingHouseSizeSuccess extends PaintingStates {
  final List<HouseSizeModel> houseSizes;
  GetPaintingHouseSizeSuccess(this.houseSizes);
}

class GetPaintingHouseSizeError extends PaintingStates {
  final String error;
  GetPaintingHouseSizeError(this.error);
}

class PaintingPromoCodeLoading extends PaintingStates {}

class PaintingPromoCodeSuccess extends PaintingStates {
  final PromoCodeResponse promoCode;
  PaintingPromoCodeSuccess(this.promoCode);
}

class PaintingPromoCodeError extends PaintingStates {
  final String error;
  PaintingPromoCodeError(this.error);
}

class PaintingPromoCodeRemoved extends PaintingStates {}

class PaintingLocationsLoading extends PaintingStates {}

class PaintingLocationsSuccess extends PaintingStates {
  final List<LocationModel> locations;
  PaintingLocationsSuccess(this.locations);
}

class PaintingLocationsError extends PaintingStates {
  final String message;
  PaintingLocationsError(this.message);
}
class GetColorsLoading extends PaintingStates {}

class GetColorsSuccess extends PaintingStates {
  final List<GetColorsResponseModel> colors;
  GetColorsSuccess(this.colors);
}

class GetColorsError extends PaintingStates {
  final String error;
  GetColorsError(this.error);
}
class PaintingColorSelected extends PaintingStates {
  final GetColorsResponseModel color;

  PaintingColorSelected(this.color);
}
