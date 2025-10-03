import 'package:engzly/features/services/house_shifting/data/models/furniture_model.dart';
import 'package:engzly/features/services/house_shifting/ui/house_shifting_service/first_screen/widgets/furniture_widgets/furniture_grid.dart';
import 'package:engzly/features/services/house_shifting/ui/house_shifting_service/first_screen/widgets/furniture_widgets/furniture_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FurnitureSection extends StatelessWidget {
  final List<FurnitureModel> furnitures;

  const FurnitureSection({super.key, required this.furnitures});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FurnitureHeader(furnituresCount: furnitures.length),
          Text(
            "Approximate furnitures",
            style: TextStyle(fontSize: 14.sp, color: Colors.grey.shade500),
          ),
          10.verticalSpace,
          FurnitureGrid(furnitures: furnitures),
        ],
      ),
    );
  }
}
