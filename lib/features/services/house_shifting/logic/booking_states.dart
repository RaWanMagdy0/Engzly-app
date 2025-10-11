import 'package:engzly/features/services/house_shifting/data/models/booking/booking_response.dart';
import 'package:engzly/features/services/house_shifting/data/models/house_size_model.dart';
import 'package:engzly/features/services/house_shifting/data/models/furniture_model.dart';
import 'package:engzly/features/services/house_shifting/data/models/promo_code_response.dart';

abstract class HouseShiftingBookingState {}

class HouseShiftingBookingInitial extends HouseShiftingBookingState {}

class HouseSizeSelected extends HouseShiftingBookingState {
  final HouseSizeModel selected;
  HouseSizeSelected(this.selected);
}

class FurnitureSelected extends HouseShiftingBookingState {
  final Map<FurnitureModel, int> selectedFurnitureCounts;
  FurnitureSelected(this.selectedFurnitureCounts);
}

class BoxesCount extends HouseShiftingBookingState {
  final int count;
  BoxesCount(this.count);
}
class DateSelected extends HouseShiftingBookingState {
  final DateTime date;
  DateSelected(this.date);
}

class VehicleSelected extends HouseShiftingBookingState {
  final int vehicleId;
  VehicleSelected(this.vehicleId);
}
class LocationSelected extends HouseShiftingBookingState {
  final String address;

  LocationSelected({
    required this.address,
  });
}

class CheckPromoCodeLoading extends HouseShiftingBookingState {}

class CheckPromoCodeSuccess extends HouseShiftingBookingState {
  final PromoCodeResponse promoCode;
  CheckPromoCodeSuccess(this.promoCode);
}

class CheckPromoCodeError extends HouseShiftingBookingState {
  final String error;
  CheckPromoCodeError(this.error);
}

class PromoCodeRemoved extends HouseShiftingBookingState {}

class CheckOutOrderLoading extends HouseShiftingBookingState {}

class CheckOutOrderSuccess extends HouseShiftingBookingState {
  final List<BookingResponse> booking;
  CheckOutOrderSuccess(this.booking);
}

class CheckOutOrderError extends HouseShiftingBookingState {
  final String message;
  CheckOutOrderError(this.message);
}
