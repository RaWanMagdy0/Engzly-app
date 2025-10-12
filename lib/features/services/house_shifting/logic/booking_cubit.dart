import 'package:engzly/core/networking/api/api_result.dart';
import 'package:engzly/core/networking/base_view_model.dart';
import 'package:engzly/features/services/house_shifting/data/models/booking/house_booking_request_model.dart';
import 'package:engzly/features/services/house_shifting/data/models/booking/house_booking_response.dart';
import 'package:engzly/features/services/house_shifting/data/models/promo_code_response.dart';
import 'package:engzly/features/services/house_shifting/data/repo/house_shifting_repo.dart';
import 'package:engzly/features/services/house_shifting/logic/booking_states.dart';
import 'package:engzly/features/services/house_shifting/data/models/house_size_model.dart';
import 'package:engzly/features/services/house_shifting/data/models/furniture_model.dart';
import 'package:injectable/injectable.dart';

@injectable
class HouseShiftingBookingCubit
    extends BaseViewModel<HouseShiftingBookingState> {
  final HouseShiftingRepo _repo;

  HouseShiftingBookingCubit(this._repo) : super(HouseShiftingBookingInitial());

  
  HouseSizeModel? selectedHouseSize;
  int? selectedHouseSizePrice;
  Map<FurnitureModel, int> selectedFurnitureCounts = {};

  int boxesCount = 0;
  int? selectedVehicleId;
  String? selectedVehicleName;
  double? selectedVehiclePrice;
  String? address;

  DateTime? selectedDate;

  String? appliedPromoCode;
 double? discountPercentage;
  double get totalPrice {
    double total = 0;

    if (selectedHouseSizePrice != null) {
      total += selectedHouseSizePrice!;
    }
    total += totalFurniturePrice;

    if (selectedVehiclePrice != null) {
      total += selectedVehiclePrice!;
    }

    total += (boxesCount * 5);
    total += 2;

    return total;
  }

  double get totalPriceAfterDiscount {
    double total = totalPrice;

    if (discountPercentage != null && discountPercentage! > 0) {
      total -= total * (discountPercentage! / 100);
    }

    return total < 0 ? 0 : total;
  }

  Future<void> checkPromoCode(String code) async {
    emit(CheckPromoCodeLoading());

    final result = await _repo.checkPromoCode(code);

    if (result is Success<PromoCodeResponse>) {
      final response = result.data!;

      appliedPromoCode = code;
      discountPercentage = response.discountPercentage;

      emit(CheckPromoCodeSuccess(response));
    } else if (result is Fail) {
      final failResult = result as Fail;
      final errorMessage = getErrorMessageFromException(failResult.exception);
      emit(CheckPromoCodeError(errorMessage));
    }
  }

  void removePromoCode() {
    appliedPromoCode = null;
    discountPercentage = null;
    emit(PromoCodeRemoved());
  }

  double get totalFurniturePrice {
    double total = 0;
    selectedFurnitureCounts.forEach((furniture, count) {
      total += (furniture.price * count);
    });
    return total;
  }

  void updateBoxesCount(int count) {
    boxesCount = count;
    emit(BoxesCount(count));
  }

  void selectHouseSize(HouseSizeModel size, int houseSizePrice) {
    selectedHouseSize = size;
    selectedHouseSizePrice = houseSizePrice;
    emit(HouseSizeSelected(size));
  }

  void incrementFurniture(FurnitureModel furniture) {
    selectedFurnitureCounts.update(furniture, (v) => v + 1, ifAbsent: () => 1);
    emit(FurnitureSelected(selectedFurnitureCounts));
  }

  void decrementFurniture(FurnitureModel furniture) {
    if (!selectedFurnitureCounts.containsKey(furniture)) return;
    final current = selectedFurnitureCounts[furniture]!;
    if (current > 1) {
      selectedFurnitureCounts[furniture] = current - 1;
    } else {
      selectedFurnitureCounts.remove(furniture);
    }
    emit(FurnitureSelected(selectedFurnitureCounts));
  }

  int get totalItemsCount {
    return selectedFurnitureCounts.values.fold(0, (sum, v) => sum + v);
  }

  void selectVehicle(int vehicleId, String vehicleName, double vehiclePrice) {
    selectedVehicleId = vehicleId;
    selectedVehicleName = vehicleName;
    selectedVehiclePrice = vehiclePrice;
    emit(VehicleSelected(vehicleId));
  }

  void selectDate(DateTime date) {
    selectedDate = date;
    emit(DateSelected(date));
  }

  void selectLocation(String newAddress) {
  address = newAddress;
  emit(LocationSelected(address: newAddress));
}

  Future<void> checkOut({
    required DateTime schedule,
    required double totalPrice,
    required int serviceId,
    required String location,
    required String promoCodes,
    required int paymentMethodId,
    required int houseSizeId,
    required int vehiclesId,
    required int packedBoxes,
    required Map<String, int> furnitures,
  }) async {
    emit(CheckOutOrderLoading());

    final bookingRequest = HouseBookingRequestModel(
        schedule: schedule,
        totalPrice: totalPrice,
        location: location,
        serviceId: serviceId,
        promoCodes: promoCodes,
        paymentMethodId: paymentMethodId,
        houseSizeId: houseSizeId,
        vehiclesId: vehiclesId,
        furnitures: furnitures,
        packedBoxes: packedBoxes);

    final result = await _repo.checkOut(bookingRequest);

    if (result is Success<HouseBookingResponse>) {
      final response = result.data;
      emit(CheckOutOrderSuccess([response!]));
    } else if (result is Fail) {
      final failResult = result as Fail;
      final errorMessage = getErrorMessageFromException(failResult.exception);
      emit(CheckOutOrderError(errorMessage));
    }
  }

  void resetSelections() {
    selectedHouseSize = null;
    selectedHouseSizePrice = null;
    selectedFurnitureCounts.clear();
    boxesCount = 0;
    selectedVehicleId = null;
    selectedVehicleName = null;
    selectedVehiclePrice = null;
    appliedPromoCode = null;
    discountPercentage = null;
    emit(HouseShiftingBookingInitial());
  }
}
