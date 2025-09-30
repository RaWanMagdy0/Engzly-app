
import 'package:engzly/features/services/house_shifting/data/models/furniture_model.dart';
import 'package:engzly/features/services/house_shifting/data/models/house_size_model.dart';

abstract class HouseShiftingState {}

class HouseShiftingInitial extends HouseShiftingState {}

class GetHouseSizeLoading extends HouseShiftingState {}

class GetHouseSizeSuccess extends HouseShiftingState {
  final List< HouseSizeModel> houseSizes;
  GetHouseSizeSuccess(this.houseSizes);
}

class GetHouseSizeError extends HouseShiftingState {
  final String error;
  GetHouseSizeError(this.error);
}



class GetFurnituresLoading extends HouseShiftingState {}

class GetFurnituresSuccess extends HouseShiftingState {
  final List< FurnitureModel> furnitures;
  GetFurnituresSuccess(this.furnitures);
}

class GetFurnituresError extends HouseShiftingState {
  final String error;
  GetFurnituresError(this.error);
}

