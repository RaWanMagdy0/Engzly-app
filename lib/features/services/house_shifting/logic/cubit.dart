import 'package:engzly/core/networking/api/api_result.dart';
import 'package:engzly/core/networking/base_view_model.dart';
import 'package:engzly/features/services/house_shifting/data/models/furniture_model.dart';
import 'package:engzly/features/services/house_shifting/data/models/house_size_model.dart';
import 'package:engzly/features/services/house_shifting/data/repo/house_shifting_repo.dart';
import 'package:engzly/features/services/house_shifting/logic/states.dart';
import 'package:injectable/injectable.dart';

@injectable
class HouseShiftingCubit extends BaseViewModel<HouseShiftingState> {
  final HouseShiftingRepo _repository;

  HouseShiftingCubit(this._repository) : super(HouseShiftingInitial());

  List<HouseSizeModel> historyResponse = [];
  List<FurnitureModel> furnitureResponse = [];

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
}
