import 'package:engzly/core/networking/api/api_result.dart';
import 'package:engzly/core/networking/base_view_model.dart';
import 'package:engzly/features/services/cleaning/data/models/request/cleaning_booking_request_model.dart';
import 'package:engzly/features/services/cleaning/data/models/response/cleaning_response_model.dart/cleaning_booking_response.dart';
import 'package:engzly/features/services/cleaning/data/models/response/house_size_model.dart/house_size_model.dart';
import 'package:engzly/features/services/cleaning/data/models/response/location_response/location_model.dart';
import 'package:engzly/features/services/cleaning/data/models/response/promo_code.dart/promo_code_response.dart';
import 'package:engzly/features/services/cleaning/data/repo/cleaning_repo.dart';
import 'package:engzly/features/services/cleaning/logic/cleaning_states.dart';
import 'package:injectable/injectable.dart';

@injectable
class CleaningCubit extends BaseViewModel<CleaningStates> {
  final CleaningRepo _cleaningRepo;

  CleaningCubit(
       this._cleaningRepo, )
      : super(CleaningInitial());

  List<HouseSizeModel> houseSizeResponse = [];
  List<LocationModel> locations = [];
  List<LocationModel> homeLocations = [];
  List<LocationModel> workLocations = [];

  HouseSizeModel? selectedHouseSize;
  int? selectedHouseSizePrice;
  int? selectedServiceId;

  String? address;
  String? appliedPromoCode;
  double? discountPercentage;

  DateTime? selectedDate;
  int requiredPersons = 0;
  int workingHours = 2;
  String? selectedPaymentType;

  CleaningBookingRequestModel? lastRequest;

////////Select house Size ////////////

  void selectHouseSize(HouseSizeModel size, int houseSizePrice) {
    selectedHouseSize = size;
    selectedHouseSizePrice = houseSizePrice;
    emit(CleaningHouseSizeSelected(size));
  }

////////Select nom of person////////////
  void increasePersons() {
    requiredPersons++;
    emit(CleaningUpdated());
  }

  void decreasePersons() {
    if (requiredPersons > 0) requiredPersons--;
    emit(CleaningUpdated());
  }
////////Select Working Hours ////////////

  void increaseWorkingHours() {
    workingHours++;
    emit(CleaningUpdated());
  }

  void decreaseWorkingHours() {
    if (workingHours > 1) workingHours--;
    emit(CleaningUpdated());
  }
////////Select date ////////////

  void selectDate(DateTime date) {
    selectedDate = date;
    emit(CleaningDateSelected(date));
  }

////////Select location ////////////
  void selectLocation(String newAddress) {
    address = newAddress;
    emit(CleaningLocationSelected(address: newAddress));
  }
////////Select ServiceId ////////////

  void selectService(int serviceId) {
    selectedServiceId = serviceId;
    emit(CleaningBookingServiceSelected(serviceId: serviceId));
  }

  ///////////////FETCH HOUSE SIZE ///////////////

  Future<void> getHouseSize() async {
    emit(GetHouseSizeLoading());

    final result = await _cleaningRepo.getHouseSize();

    if (result is Success<List<HouseSizeModel>>) {
      houseSizeResponse = result.data ?? [];
      emit(GetHouseSizeSuccess(houseSizeResponse));
    } else if (result is Fail) {
      final failResult = result as Fail;
      final errorMessage = getErrorMessageFromException(failResult.exception);
      emit(GetHouseSizeError(errorMessage));
    }
  }

  ///////////////FETCH LOCATIONS///////////////
  Future<void> getLocations() async {
    emit(CleaningLocationsLoading());

    final result = await _cleaningRepo.getLocations();

    if (result is Success<List<LocationModel>>) {
      locations = result.data!;

      homeLocations = locations.where((l) => l.type == 'home').toList();
      workLocations = locations.where((l) => l.type == 'work').toList();

      emit(CleaningLocationsSuccess(locations));
    } else if (result is Fail) {
      final failResult = result as Fail;
      final errorMessage = getErrorMessageFromException(failResult.exception);
      emit(CleaningLocationsError(errorMessage));
    }
  }

  ///////////////CHECKOUT////////////////
  Future<void> checkOut({
    required DateTime schedule,
    required double totalPrice,
    required int serviceId,
    required String location,
    required String promoCodes,
    required int paymentMethodId,
    required int houseSizeId,
  }) async {
    emit(CleaningCheckOutOrderLoading());

    final bookingRequest = CleaningBookingRequestModel(
      schedule: schedule,
      totalPrice: totalPrice,
      location: location,
      serviceId: serviceId,
      promoCodes: promoCodes,
      paymentMethodId: paymentMethodId,
      houseSizeId: houseSizeId,
    );

    lastRequest = bookingRequest;

    try {
      final result = await _cleaningRepo.checkOut(bookingRequest);

      if (result is Success<CleaningBookingResponse>) {
        emit(CleaningCheckOutOrderSuccess([result.data!]));
      } else if (result is Fail) {
        final failResult = result as Fail;

        final errorMessage = getErrorMessageFromException(failResult.exception);
        emit(CleaningCheckOutOrderError(errorMessage));
      }
    } catch (e) {
      emit(CleaningCheckOutOrderError("Unexpected Error: $e"));
    }
  }

  ////////////////// PROMO CODE////////////////
  Future<void> checkPromoCode(String code) async {
    emit(CleaningPromoCodeLoading());

    final result = await _cleaningRepo.checkPromoCode(code);

    if (result is Success<PromoCodeResponse>) {
      appliedPromoCode = code;
      discountPercentage = result.data?.discountPercentage.toDouble();
      emit(CleaningPromoCodeSuccess(result.data!));
    } else if (result is Fail) {
      final failResult = result as Fail;
      final errorMessage = getErrorMessageFromException(failResult.exception);
      emit(CleaningPromoCodeError(errorMessage));
    }
  }

  void removePromoCode() {
    appliedPromoCode = null;
    discountPercentage = null;
    emit(CleaningPromoCodeRemoved());
  }
}
