import 'package:engzly/features/services/house_shifting/data/models/house_size_model.dart';
import 'package:engzly/features/services/house_shifting/data/models/furniture_model.dart';

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
