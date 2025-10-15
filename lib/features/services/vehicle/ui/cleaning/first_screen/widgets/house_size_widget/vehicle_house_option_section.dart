import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:engzly/features/services/house_shifting/data/models/vehicle_model.dart';
import 'vehicle_option_card.dart';
import 'package:engzly/core/theming/colors.dart';

class VehicleHouseOptionSection extends StatelessWidget {
  final List<VehicleModel> options;

  const VehicleHouseOptionSection({
    super.key,
    required this.options,
  });

  @override
  Widget build(BuildContext context) {
    final updatedList = List<VehicleModel>.from(options);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 15.h,
          crossAxisSpacing: 10.w,
          childAspectRatio: 0.9,
        ),
        itemCount: updatedList.length + 1,
        itemBuilder: (context, index) {
          if (index == updatedList.length) {
            return GestureDetector(
              onTap: () {},
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(color: Colors.grey.shade300),
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 60.h,
                      width: 60.h,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.add,
                          size: 32, color: ColorsManager.orange),
                    ),
                    10.verticalSpace,
                    const Text(
                      "Custom Order",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    5.verticalSpace,
                    Text(
                      "+8 Ton, 20 Feet",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          final item = updatedList[index];
          return VehicleOptionCard(
            vehcile: item,
            vehcilePrice: item.price,
            capacity: item.capacity,
            icon: item.icon,
          );
        },
      ),
    );
  }
}
