import 'package:engzly/core/networking/api/api_result.dart';
import 'package:engzly/core/networking/base_view_model.dart';
import 'package:engzly/features/profile/data/models/get_address/location_model.dart';
import 'package:engzly/features/profile/data/repo/get_locations_repo.dart';
import 'package:engzly/features/services/cleaning/data/models/cleaning_booking_request_model.dart';
import 'package:engzly/features/services/cleaning/data/models/cleaning_booking_response.dart';
import 'package:engzly/features/services/cleaning/data/repo/cleaning_repo.dart';
import 'package:engzly/features/services/cleaning/logic/cleaning_states.dart';
import 'package:engzly/features/services/house_shifting/data/models/promo_code_response.dart';
import 'package:engzly/features/services/house_shifting/data/repo/house_shifting_repo.dart';
import 'package:engzly/features/services/house_shifting/data/models/house_size_model.dart';
import 'package:injectable/injectable.dart';

@injectable
class CleaningCubit extends BaseViewModel<CleaningStates> {
  final HouseShiftingRepo _houseShiftingRepo;
  final CleaningRepo _cleaningRepo;
  final GetLocationsRepo _getLocationsRepo;

  CleaningCubit(
      this._houseShiftingRepo, this._cleaningRepo, this._getLocationsRepo)
      : super(CleaningInitial());

  List<HouseSizeModel> houseSizeResponse = [];
  List<LocationModel> locations = [];

  HouseSizeModel? selectedHouseSize;
  int? selectedHouseSizePrice;

  String? address;
  String? appliedPromoCode;
  double? discountPercentage;

  DateTime? selectedDate;
  int requiredPersons = 0;
  int workingHours = 2;

  void selectHouseSize(HouseSizeModel size, int houseSizePrice) {
    selectedHouseSize = size;
    selectedHouseSizePrice = houseSizePrice;
    emit(CleaningHouseSizeSelected(size));
  }

  void increasePersons() {
    requiredPersons++;
    emit(CleaningUpdated());
  }

  void decreasePersons() {
    if (requiredPersons > 0) requiredPersons--;
    emit(CleaningUpdated());
  }

  void increaseWorkingHours() {
    workingHours++;
    emit(CleaningUpdated());
  }

  void decreaseWorkingHours() {
    if (workingHours > 1) workingHours--;
    emit(CleaningUpdated());
  }

  void selectDate(DateTime date) {
    selectedDate = date;
    emit(CleaningDateSelected(date));
  }

  void selectLocation(String newAddress) {
    address = newAddress;
    emit(CleaningLocationSelected(address: newAddress));
  }

  Future<void> getHouseSize() async {
    emit(GetHouseSizeLoading());

    final result = await _houseShiftingRepo.getHouseSize();

    if (result is Success<List<HouseSizeModel>>) {
      houseSizeResponse = result.data ?? [];
      emit(GetHouseSizeSuccess(houseSizeResponse));
    } else if (result is Fail) {
      final failResult = result as Fail;
      final errorMessage = getErrorMessageFromException(failResult.exception);
      emit(GetHouseSizeError(errorMessage));
    }
  }

  List<LocationModel> homeLocations = [];
  List<LocationModel> workLocations = [];

  Future<void> getLocations() async {
    emit(CleaningLocationsLoading());

    final result = await _getLocationsRepo.getLocations();

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

    final result = await _cleaningRepo.checkOut(bookingRequest);

    if (result is Success<CleaningBookingResponse>) {
      final response = result.data;
      emit(CleaningCheckOutOrderSuccess([response!]));
    } else if (result is Fail) {
      final failResult = result as Fail;
      final errorMessage = getErrorMessageFromException(failResult.exception);
      emit(CleaningCheckOutOrderError(errorMessage));
    }
  }

  Future<void> checkPromoCode(String code) async {
    emit(CleaningPromoCodeLoading());

    final result = await _houseShiftingRepo.checkPromoCode(code);

    if (result is Success<PromoCodeResponse>) {
      final response = result.data!;
      appliedPromoCode = code;
      discountPercentage = response.discountPercentage.toDouble();
      emit(CleaningPromoCodeSuccess(response));
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
