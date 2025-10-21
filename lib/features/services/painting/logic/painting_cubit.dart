import 'package:engzly/core/networking/api/api_result.dart';
import 'package:engzly/core/networking/base_view_model.dart';
import 'package:engzly/features/profile/data/models/get_address/location_model.dart';
import 'package:engzly/features/profile/data/repo/get_locations_repo.dart';
import 'package:engzly/features/services/house_shifting/data/models/promo_code_response.dart';
import 'package:engzly/features/services/house_shifting/data/repo/house_shifting_repo.dart';
import 'package:engzly/features/services/house_shifting/data/models/house_size_model.dart';
import 'package:engzly/features/services/painting/data/models/get_colors_response_model.dart';
import 'package:engzly/features/services/painting/data/models/painting_booking_request_model.dart';
import 'package:engzly/features/services/painting/data/models/painting_booking_response.dart';
import 'package:engzly/features/services/painting/data/repo/painting_repo.dart';
import 'package:engzly/features/services/painting/logic/painting_states.dart';
import 'package:injectable/injectable.dart';

@injectable
class PaintingCubit extends BaseViewModel<PaintingStates> {
  final HouseShiftingRepo _houseShiftingRepo;
  final PaintingRepo _paintingRepo;
  final GetLocationsRepo _getLocationsRepo;

  PaintingCubit(
      this._houseShiftingRepo, this._paintingRepo, this._getLocationsRepo)
      : super(PaintingInitial());

  List<HouseSizeModel> houseSizeResponse = [];
  List<LocationModel> locations = [];
  List<GetColorsResponseModel> colorsResponse = [];

  HouseSizeModel? selectedHouseSize;
  int? selectedHouseSizePrice;

  String? address;
  String? appliedPromoCode;
  double? discountPercentage;

  DateTime? selectedDate;
  int requiredPersons = 0;
  GetColorsResponseModel? selectedColor;

  void selectColor(GetColorsResponseModel color) {
    selectedColor = color;
    emit(PaintingColorSelected(color));
  }

  void selectHouseSize(HouseSizeModel size, int houseSizePrice) {
    selectedHouseSize = size;
    selectedHouseSizePrice = houseSizePrice;
    emit(PaintingHouseSizeSelected(size));
  }

  void increaserequiredPersons() {
    requiredPersons++;
    emit(PaintingUpdated());
  }

  void decreaserequiredPersons() {
    if (requiredPersons > 1) requiredPersons--;
    emit(PaintingUpdated());
  }

  void selectDate(DateTime date) {
    selectedDate = date;
    emit(PaintingDateSelected(date));
  }

  void selectLocation(String newAddress) {
    address = newAddress;
    emit(PaintingLocationSelected(address: newAddress));
  }

  Future<void> getHouseSize() async {
    emit(GetPaintingHouseSizeLoading());

    final result = await _houseShiftingRepo.getHouseSize();

    if (result is Success<List<HouseSizeModel>>) {
      houseSizeResponse = result.data ?? [];
      emit(GetPaintingHouseSizeSuccess(houseSizeResponse));
    } else if (result is Fail) {
      final failResult = result as Fail;
      final errorMessage = getErrorMessageFromException(failResult.exception);
      emit(GetPaintingHouseSizeError(errorMessage));
    }
  }

  List<LocationModel> homeLocations = [];
  List<LocationModel> workLocations = [];

  Future<void> getLocations() async {
    emit(PaintingLocationsLoading());

    final result = await _getLocationsRepo.getLocations();

    if (result is Success<List<LocationModel>>) {
      locations = result.data!;

      homeLocations = locations.where((l) => l.type == 'home').toList();
      workLocations = locations.where((l) => l.type == 'work').toList();

      emit(PaintingLocationsSuccess(locations));
    } else if (result is Fail) {
      final failResult = result as Fail;
      final errorMessage = getErrorMessageFromException(failResult.exception);
      emit(PaintingLocationsError(errorMessage));
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
    required int colorId,
  }) async {
    emit(PaintingCheckOutOrderLoading());

    final bookingRequest = PaintingBookingRequestModel(
      schedule: schedule,
      totalPrice: totalPrice,
      location: location,
      serviceId: serviceId,
      promoCodes: promoCodes,
      paymentMethodId: paymentMethodId,
      houseSizeId: houseSizeId,
      colorId: colorId,
    );

    final result = await _paintingRepo.checkOut(bookingRequest);

    if (result is Success<PaintingBookingResponse>) {
      final response = result.data;
      emit(PaintingCheckOutOrderSuccess([response!]));
    } else if (result is Fail) {
      final failResult = result as Fail;
      final errorMessage = getErrorMessageFromException(failResult.exception);
      emit(PaintingCheckOutOrderError(errorMessage));
    }
  }

  Future<void> checkPromoCode(String code) async {
    emit(PaintingPromoCodeLoading());

    final result = await _houseShiftingRepo.checkPromoCode(code);

    if (result is Success<PromoCodeResponse>) {
      final response = result.data!;
      appliedPromoCode = code;
      discountPercentage = response.discountPercentage.toDouble();
      emit(PaintingPromoCodeSuccess(response));
    } else if (result is Fail) {
      final failResult = result as Fail;
      final errorMessage = getErrorMessageFromException(failResult.exception);
      emit(PaintingPromoCodeError(errorMessage));
    }
  }

  void removePromoCode() {
    appliedPromoCode = null;
    discountPercentage = null;
    emit(PaintingPromoCodeRemoved());
  }

  Future<void> getColors() async {
    emit(GetColorsLoading());

    final result = await _paintingRepo.getColors();

    if (result is Success<List<GetColorsResponseModel>>) {
      colorsResponse = result.data ?? [];
      emit(GetColorsSuccess(colorsResponse));
    } else if (result is Fail) {
      final failResult = result as Fail;
      final errorMessage = getErrorMessageFromException(failResult.exception);
      emit(GetColorsError(errorMessage));
    }
  }
}
