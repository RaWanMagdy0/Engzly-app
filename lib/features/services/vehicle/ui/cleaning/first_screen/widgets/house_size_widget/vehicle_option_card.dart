import 'package:engzly/core/theming/colors.dart';
import 'package:engzly/core/theming/fonts.dart';
import 'package:engzly/features/services/house_shifting/data/models/vehicle_model.dart';
import 'package:engzly/features/services/vehicle/logic/vehicle_cubit.dart';
import 'package:engzly/features/services/vehicle/logic/vehicle_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VehicleOptionCard extends StatelessWidget {
  final VehicleModel vehcile;
  final double vehcilePrice;
  final String icon;
  final double capacity;
  const VehicleOptionCard(
      {super.key,
      required this.vehcile,
      required this.vehcilePrice,
      required this.capacity,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VehicleCubit, VehicleStates>(
      builder: (context, state) {
        final cubit = context.watch<VehicleCubit>();
        final isSelected = cubit.selectedVehcile?.id == vehcile.id;

        return GestureDetector(
          onTap: () {
            cubit.selectVehicle(vehcile, vehcilePrice, icon, capacity);
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.r),
              border: Border.all(
                color: isSelected ? ColorsManager.orange : Colors.grey.shade300,
                width: isSelected ? 2 : 1,
              ),
              color: Colors.white,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(
                  vehcile.icon,
                  height: 70.h,
                  width: double.infinity,
                  fit: BoxFit.contain,
                ),
                8.verticalSpace,
                Text(
                  vehcile.name,
                  textAlign: TextAlign.center,
                  style: AppFonts.font13BlackWeight500.copyWith(
                    color: Colors.grey.shade700,
                  ),
                ),
                5.verticalSpace,
                Text(
                  "~ ${vehcile.capacity} Ton",
                  textAlign: TextAlign.center,
                  style: AppFonts.font13BlackWeight500.copyWith(
                    color: Colors.grey.shade700,
                  ),
                ),
                5.verticalSpace,
                Text(
                  "\$${vehcile.price}",
                  style: AppFonts.font13BlackWeight500.copyWith(
                    color: ColorsManager.orange,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
