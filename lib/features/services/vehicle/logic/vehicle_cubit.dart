import 'package:engzly/core/networking/api/api_result.dart';
import 'package:engzly/core/networking/base_view_model.dart';
import 'package:engzly/features/profile/data/models/get_address/location_model.dart';
import 'package:engzly/features/profile/data/repo/get_locations_repo.dart';
import 'package:engzly/features/services/house_shifting/data/models/promo_code_response.dart';
import 'package:engzly/features/services/house_shifting/data/models/vehicle_model.dart';
import 'package:engzly/features/services/house_shifting/data/repo/house_shifting_repo.dart';
import 'package:engzly/features/services/house_shifting/data/models/house_size_model.dart';
import 'package:engzly/features/services/vehicle/data/models/vehicle_booking_request_model.dart';
import 'package:engzly/features/services/vehicle/data/models/vehicle_booking_response.dart';
import 'package:engzly/features/services/vehicle/data/repo/vehicle_repo.dart';
import 'package:engzly/features/services/vehicle/logic/vehicle_states.dart';
import 'package:injectable/injectable.dart';

@injectable
class VehicleCubit extends BaseViewModel<VehicleStates> {
  final HouseShiftingRepo _houseShiftingRepo;
  final GetLocationsRepo _getLocationsRepo;
  final VehicleRepo _vehicleRepo;

  VehicleCubit(
      this._houseShiftingRepo, this._vehicleRepo, this._getLocationsRepo)
      : super(VehicleInitial());

  List<HouseSizeModel> houseSizeResponse = [];
  List<LocationModel> locations = [];
  List<VehicleModel> vehicleResponse = [];

  VehicleModel? selectedVehcile;
  double? selectedVehcilePrice;
  String? selectedIcon;
  double? selectedCapacity;
  String? address;
  String? appliedPromoCode;
  double? discountPercentage;
  int? selectedServiceId;

  DateTime? selectedDate;
  int requiredPersons = 0;
  int workingHours = 2;
String? selectedPaymentType;
  void selectVehicle(
      VehicleModel vehicle, double vehiclePrice, String icon, double capacity) {
    selectedVehcile = vehicle;
    selectedVehcilePrice = vehiclePrice;
    selectedIcon = icon;
    selectedCapacity = capacity;
    emit(VehicleSelected(vehicle));
  }

  void selectLocation(String newAddress) {
    address = newAddress;
    emit(VechicleLocationSelected(address: newAddress));
  }

  List<LocationModel> homeLocations = [];
  List<LocationModel> workLocations = [];

  void selectDate(DateTime date) {
    selectedDate = date;
    emit(VehcileDateSelected(date));
  }

  void selectService(int serviceId) {
    selectedServiceId = serviceId;
    emit(VehicleBookingServiceSelected(serviceId: serviceId));
  }

  Future<void> getVehicles() async {
    emit(GetVehicleVehiclesLoading());

    final result = await _houseShiftingRepo.getVehicles();

    if (result is Success<List<VehicleModel>>) {
      vehicleResponse = result.data ?? [];
      emit(GetVehicleVehiclesSuccess(vehicleResponse));
    } else if (result is Fail) {
      final failResult = result as Fail;
      final errorMessage = getErrorMessageFromException(failResult.exception);
      emit(GetVehicleVehiclesError(errorMessage));
    }
  }

  Future<void> getLocations() async {
    emit(VehicleLocationsLoading());

    final result = await _getLocationsRepo.getLocations();

    if (result is Success<List<LocationModel>>) {
      locations = result.data!;

      homeLocations = locations.where((l) => l.type == 'home').toList();
      workLocations = locations.where((l) => l.type == 'work').toList();

      emit(VehicleLocationsSuccess(locations));
    } else if (result is Fail) {
      final failResult = result as Fail;
      final errorMessage = getErrorMessageFromException(failResult.exception);
      emit(VehicleLocationsError(errorMessage));
    }
  }

  Future<void> checkOut({
    required DateTime schedule,
    required double totalPrice,
    required int serviceId,
    required String location,
    required String promoCodes,
    required int paymentMethodId,
    required int vehicleId,
  }) async {
    emit(VehicleCheckOutOrderLoading());

    final bookingRequest = VehicleBookingRequestModel(
      schedule: schedule,
      totalPrice: totalPrice,
      location: location,
      serviceId: serviceId,
      promoCodes: promoCodes,
      paymentMethodId: paymentMethodId,
      vehicleId: vehicleId,
    );

    final result = await _vehicleRepo.vehicleCheckOut(bookingRequest);

    if (result is Success<VehicleBookingResponse>) {
      final response = result.data;
      emit(VehicleCheckOutOrderSuccess([response!]));
    } else if (result is Fail) {
      final failResult = result as Fail;
      final errorMessage = getErrorMessageFromException(failResult.exception);
      emit(VehicleCheckOutOrderError(errorMessage));
    }
  }

  Future<void> checkPromoCode(String code) async {
    emit(VehiclePromoCodeLoading());

    final result = await _houseShiftingRepo.checkPromoCode(code);

    if (result is Success<PromoCodeResponse>) {
      final response = result.data!;
      appliedPromoCode = code;
      discountPercentage = response.discountPercentage.toDouble();
      emit(VehiclePromoCodeSuccess(response));
    } else if (result is Fail) {
      final failResult = result as Fail;
      final errorMessage = getErrorMessageFromException(failResult.exception);
      emit(VehiclePromoCodeError(errorMessage));
    }
  }

  void removePromoCode() {
    appliedPromoCode = null;
    discountPercentage = null;
    emit(VehiclePromoCodeRemoved());
  }
}
