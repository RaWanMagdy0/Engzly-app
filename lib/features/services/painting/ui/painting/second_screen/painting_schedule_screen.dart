import 'package:engzly/core/shared_widgets/custom_botton.dart';
import 'package:engzly/core/shared_widgets/custom_scaffold.dart';
import 'package:engzly/core/theming/colors.dart';
import 'package:engzly/core/theming/fonts.dart';
import 'package:engzly/core/theming/images.dart';

import 'package:engzly/features/services/painting/logic/painting_cubit.dart';
import 'package:engzly/features/services/painting/ui/painting/second_screen/widgets/painting_calender_widget.dart';
import 'package:engzly/features/services/painting/ui/painting/third_screen/painting_choose_location.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class PaintingScheduleScreen extends StatelessWidget {
  const PaintingScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<PaintingCubit>();

    return CustomScaffoldScreen(
      title: Text(
        "Schedule Painting",
      ),
      leadingIcon: SvgPicture.asset(AppImages.backArrow,
          width: 30.w, height: 30.h, color: ColorsManager.black),
      notificationIcon: Image.asset(AppImages.notificationIcon,
          width: 28.w, height: 28.h, color: ColorsManager.black),
      onLeadingTap: () => Navigator.pop(context),
      onNotificationTap: () {},
      showNotificationDot: true,
      child: Column(
        children: [
          20.verticalSpace,
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: PaintingCalenderWidget(
              onDateSelected: (selectedDate) {
                cubit.selectDate(selectedDate);
              },
            ),
          ),
          300.verticalSpace,
          CustomButton(
            borderRadius: 15.r,
            height: 50.h,
            width: 300.w,
            onPressed: () {
              if (cubit.selectedDate == null) {
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
                      BlocProvider.value(value: cubit),
                    ],
                    child: PaintingChooseLocation(),
                  ),
                ),
              );
            },
            text: "Proceed",
            color: ColorsManager.yellow,
            textStyle: AppFonts.font14BWhiteWeight700,
          ),
        ],
      ),
    );
  }
}
