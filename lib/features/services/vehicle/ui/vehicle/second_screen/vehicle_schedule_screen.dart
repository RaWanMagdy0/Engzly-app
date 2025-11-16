import 'package:engzly/core/shared_widgets/custom_botton.dart';
import 'package:engzly/core/shared_widgets/custom_scaffold.dart';
import 'package:engzly/core/theming/colors.dart';
import 'package:engzly/core/theming/fonts.dart';
import 'package:engzly/core/theming/images.dart';
import 'package:engzly/features/services/vehicle/logic/vehicle_cubit.dart';
import 'package:engzly/features/services/vehicle/ui/vehicle/second_screen/widgets/vehicle_calender_widget.dart';
import 'package:engzly/features/services/vehicle/ui/vehicle/third_screen/vehicle_choose_location.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class VehicleScheduleScreen extends StatelessWidget {
  const VehicleScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vehicleCubit = context.read<VehicleCubit>();

    return CustomScaffoldScreen(
      title: Text(
        "Schedule Vehcile",
      ),
      leadingIcon: SvgPicture.asset(AppImages.backArrow,
          width: 30.w, height: 30.h, color: ColorsManager.black),
      notificationIcon: Image.asset(AppImages.notificationIcon,
          width: 28.w, height: 28.h, color: ColorsManager.black),
      onLeadingTap: () => Navigator.pop(context),
      onNotificationTap: () {},
      child: Column(
        children: [
          20.verticalSpace,
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: VehicleCalenderWidget(
              onDateSelected: (selectedDate) {
                vehicleCubit.selectDate(selectedDate);
              },
            ),
          ),
          const Spacer(),
          CustomButton(
            borderRadius: 15.r,
            height: 50.h,
            width: 300.w,
            onPressed: () {
              if (vehicleCubit.selectedDate == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Please select a date first')),
                );
                return;
              }

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => MultiBlocProvider(
                    providers: [
                      BlocProvider.value(value: vehicleCubit),
                    ],
                    child: VehicleChooseLocation(),
                  ),
                ),
              );
            },
            text: "Proceed",
            color: ColorsManager.orange,
            textStyle: AppFonts.font14BWhiteWeight700,
          ),
          20.verticalSpace
        ],
      ),
    );
  }
}
