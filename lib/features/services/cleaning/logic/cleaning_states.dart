import 'package:engzly/features/services/cleaning/data/models/cleaning_booking_response.dart';
import 'package:engzly/features/services/house_shifting/data/models/house_size_model.dart';
import 'package:engzly/features/services/house_shifting/data/models/promo_code_response.dart';

abstract class CleaningStates {}

class CleaningInitial extends CleaningStates {}

class CleaningHouseSizeSelected extends CleaningStates {
  final HouseSizeModel selected;
  CleaningHouseSizeSelected(this.selected);
}



class CleaningDateSelected extends CleaningStates {
  final DateTime date;
  CleaningDateSelected(this.date);
}

class CleaningLocationSelected extends CleaningStates {
  final String address;

  CleaningLocationSelected({
    required this.address,
  });
}

class CleaningUpdated extends CleaningStates {}

class CleaningCheckOutOrderLoading extends CleaningStates {}

class CleaningCheckOutOrderSuccess extends CleaningStates {
  final List<CleaningBookingResponse> booking;
  CleaningCheckOutOrderSuccess(this.booking);
}

class CleaningCheckOutOrderError extends CleaningStates {
  final String message;
  CleaningCheckOutOrderError(this.message);
}


class GetHouseSizeLoading extends CleaningStates {}

class GetHouseSizeSuccess extends CleaningStates {
  final List<HouseSizeModel> houseSizes;
  GetHouseSizeSuccess(this.houseSizes);
}

class GetHouseSizeError extends CleaningStates {
  final String error;
  GetHouseSizeError(this.error);
}
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
