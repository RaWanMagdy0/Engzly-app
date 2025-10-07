import 'package:engzly/features/services/house_shifting/logic/booking_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:engzly/features/services/house_shifting/data/models/house_size_model.dart';
import 'package:engzly/features/services/house_shifting/data/models/furniture_model.dart';
import 'package:injectable/injectable.dart';

@injectable
class HouseShiftingBookingCubit extends Cubit<HouseShiftingBookingState> {
  HouseShiftingBookingCubit() : super(HouseShiftingBookingInitial());

  HouseSizeModel? selectedHouseSize;
  Map<FurnitureModel, int> selectedFurnitureCounts = {};
  int boxesCount = 0;

  void selectHouseSize(HouseSizeModel size) {
    selectedHouseSize = size;
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

  void updateBoxesCount(int count) {
    boxesCount = count;
    emit(BoxesCount(count));
  }

  void resetSelections() {
    selectedHouseSize = null;
    selectedFurnitureCounts.clear();
    boxesCount = 0;
    emit(HouseShiftingBookingInitial());
  }
}
