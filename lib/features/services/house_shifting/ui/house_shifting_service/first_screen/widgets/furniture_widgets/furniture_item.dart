import 'package:engzly/core/theming/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:engzly/features/services/house_shifting/logic/booking_cubit.dart';
import 'package:engzly/features/services/house_shifting/logic/booking_states.dart';
import 'package:engzly/features/services/house_shifting/data/models/furniture_model.dart';

class FurnitureItem extends StatelessWidget {
  final FurnitureModel furniture;
  const FurnitureItem({super.key, required this.furniture});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HouseShiftingBookingCubit, HouseShiftingBookingState>(
      builder: (context, state) {
        final cubit = context.read<HouseShiftingBookingCubit>();
        final count = cubit.selectedFurnitureCounts[furniture] ?? 0;
        final isSelected = count > 0;

        return GestureDetector(
          onTap: () => cubit.incrementFurniture(furniture),
          onLongPress: () => cubit.decrementFurniture(furniture),
          child: Stack(
            alignment: Alignment.topRight,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: EdgeInsets.all(3.w),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isSelected ? Colors.orange : Colors.transparent,
                        width: 2.w,
                      ),
                    ),
                    child: Image.network(
                      furniture.icon,
                      height: 50.h,
                      width: 50.w,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.broken_image, color: Colors.grey),
                    ),
                  ),
                  Text(
                    furniture.name,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
              if (count > 0)
                Positioned(
                  top: 0,
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                    decoration: BoxDecoration(
                      color: ColorsManager.orange,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Text(
                      'x $count',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
