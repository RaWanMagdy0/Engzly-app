import 'package:engzly/core/theming/colors.dart';
import 'package:engzly/features/services/house_shifting/logic/booking_cubit.dart';
import 'package:engzly/features/services/house_shifting/logic/booking_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:engzly/features/services/house_shifting/data/models/house_size_model.dart';

class HouseOptionCard extends StatelessWidget {
  final HouseSizeModel houseSize;

  const HouseOptionCard({
    super.key,
    required this.houseSize,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HouseShiftingBookingCubit, HouseShiftingBookingState>(
      builder: (context, state) {
        final cubit = context.read<HouseShiftingBookingCubit>();
        final isSelected = cubit.selectedHouseSize?.id == houseSize.id;

        return GestureDetector(
          onTap: () => cubit.selectHouseSize(houseSize),
          child: Container(
            height: 140.h,
            width: 110.w,
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
                  houseSize.icon,
                  height: 70.h,
                  width: 70.w,
                  fit: BoxFit.contain,
                ),
                8.verticalSpace,
                Text(
                  houseSize.name,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
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
