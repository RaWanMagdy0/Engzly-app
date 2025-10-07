import 'package:engzly/core/networking/api/api_result.dart';
import 'package:engzly/core/networking/base_view_model.dart';
import 'package:engzly/features/profile/data/models/get_address/location_model.dart';
import 'package:engzly/features/profile/data/repo/get_locations_repo.dart';
import 'package:engzly/features/services/house_shifting/data/models/furniture_model.dart';
import 'package:engzly/features/services/house_shifting/data/models/house_size_model.dart';
import 'package:engzly/features/services/house_shifting/data/models/vehicle_model.dart';
import 'package:engzly/features/services/house_shifting/data/repo/house_shifting_repo.dart';
import 'package:engzly/features/services/house_shifting/logic/states.dart';
import 'package:injectable/injectable.dart';

@injectable
class HouseShiftingCubit extends BaseViewModel<HouseShiftingState> {
  final HouseShiftingRepo _repository;
  final GetLocationsRepo _getLocationsRepo;

  HouseShiftingCubit(this._repository, this._getLocationsRepo)
      : super(HouseShiftingInitial());

  List<HouseSizeModel> historyResponse = [];
  List<FurnitureModel> furnitureResponse = [];
  List<VehicleModel> vehicleResponse = [];
  List<LocationModel> locations = [];

  Future<void> getHouseSize() async {
    emit(GetHouseSizeLoading());

    final result = await _repository.getHouseSize();

    if (result is Success<List<HouseSizeModel>>) {
      historyResponse = result.data ?? [];
      emit(GetHouseSizeSuccess(historyResponse));
    } else if (result is Fail) {
      final failResult = result as Fail;
      final errorMessage = getErrorMessageFromException(failResult.exception);
      emit(GetHouseSizeError(errorMessage));
    }
  }

  Future<void> getFurnitures() async {
    emit(GetFurnituresLoading());

    final result = await _repository.getFurnitures();

    if (result is Success<List<FurnitureModel>>) {
      furnitureResponse = result.data ?? [];
      emit(GetFurnituresSuccess(furnitureResponse));
    } else if (result is Fail) {
      final failResult = result as Fail;
      final errorMessage = getErrorMessageFromException(failResult.exception);
      emit(GetFurnituresError(errorMessage));
    }
  }

  Future<void> getVehicles() async {
    emit(GetVehiclesLoading());

    final result = await _repository.getVehicles();

    if (result is Success<List<VehicleModel>>) {
      vehicleResponse = result.data ?? [];
      emit(GetVehiclesSuccess(vehicleResponse));
    } else if (result is Fail) {
      final failResult = result as Fail;
      final errorMessage = getErrorMessageFromException(failResult.exception);
      emit(GetVehiclesError(errorMessage));
    }
  }

  List<LocationModel> homeLocations = [];
  List<LocationModel> workLocations = [];

  Future<void> getLocations() async {
    emit(ConfirmLocationsLoading());

    final result = await _getLocationsRepo.getLocations();

    if (result is Success<List<LocationModel>>) {
      locations = result.data!;

      homeLocations = locations.where((l) => l.type == 'home').toList();
      workLocations = locations.where((l) => l.type == 'work').toList();

      emit(ConfirmLocationsSuccess(locations));
    } else if (result is Fail) {
      final failResult = result as Fail;
      final errorMessage = getErrorMessageFromException(failResult.exception);
      emit(ConfirmLocationsError(errorMessage));
    }
  }
}
