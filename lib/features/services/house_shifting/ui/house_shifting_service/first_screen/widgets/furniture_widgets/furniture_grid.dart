import 'package:engzly/features/services/house_shifting/data/models/furniture_model.dart';
import 'package:engzly/features/services/house_shifting/ui/house_shifting_service/first_screen/widgets/furniture_widgets/furniture_item.dart';
import 'package:flutter/material.dart';

class FurnitureGrid extends StatelessWidget {
  final List<FurnitureModel> furnitures;

  const FurnitureGrid({super.key, required this.furnitures});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 5,
        childAspectRatio: 0.8,
      ),
      itemCount: furnitures.length,
      itemBuilder: (context, index) {
        return FurnitureItem(furniture: furnitures[index]);
      },
    );
  }
}
