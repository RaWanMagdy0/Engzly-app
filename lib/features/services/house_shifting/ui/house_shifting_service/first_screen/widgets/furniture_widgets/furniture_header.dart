import 'package:engzly/core/theming/fonts.dart';
import 'package:engzly/features/services/house_shifting/logic/booking_cubit.dart';
import 'package:engzly/features/services/house_shifting/logic/booking_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FurnitureHeader extends StatelessWidget {
  final int furnituresCount;

  const FurnitureHeader({super.key, required this.furnituresCount});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Furnitures",
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
TextButton(
  onPressed: () {},
  style: ButtonStyle(
    backgroundColor: WidgetStateProperty.all(Colors.grey.shade100),
  ),
  child: BlocBuilder<HouseShiftingBookingCubit, HouseShiftingBookingState>(
    builder: (context, state) {
      final cubit = context.read<HouseShiftingBookingCubit>();
      final total = cubit.totalItemsCount;
      return Text(
        "$total Items",
        style: AppFonts.font20BlackWeight700.copyWith(fontSize: 12.sp),
      );
    },
  ),
),

      ],
    );
  }
}
