import 'package:engzly/core/theming/colors.dart';
import 'package:engzly/core/theming/fonts.dart';
import 'package:engzly/features/services/painting/logic/painting_cubit.dart';
import 'package:engzly/features/services/painting/logic/painting_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:engzly/features/services/house_shifting/data/models/house_size_model.dart';

class PaintingHouseOptionCard extends StatelessWidget {
  final HouseSizeModel houseSize;
  final int houseSizePrice;

  const PaintingHouseOptionCard({
    super.key,
    required this.houseSize,
    required this.houseSizePrice,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaintingCubit, PaintingStates>(
      builder: (context, state) {
        final cubit = context.watch<PaintingCubit>();
        final isSelected = cubit.selectedHouseSize?.id == houseSize.id;

        return GestureDetector(
          onTap: () {
            cubit.selectHouseSize(houseSize, houseSizePrice);
          },
          child: Container(
            height: 160.h,
            width: 110.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.r),
              border: Border.all(
                color: isSelected ? ColorsManager.green : Colors.grey.shade300,
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
                  width: double.infinity,
                  fit: BoxFit.contain,
                ),
                8.verticalSpace,
                Text(
                  houseSize.name,
                  textAlign: TextAlign.center,
                  style: AppFonts.font13BlackWeight500.copyWith(
                    color: Colors.grey.shade700,
                  ),
                ),
                5.verticalSpace,
                Text(
                  "\$${houseSize.price}",
                  style: AppFonts.font13BlackWeight500.copyWith(
                    color: ColorsManager.yellow,
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
