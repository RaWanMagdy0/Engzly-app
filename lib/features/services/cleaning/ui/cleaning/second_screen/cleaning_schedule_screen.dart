import 'package:engzly/core/shared_widgets/custom_botton.dart';
import 'package:engzly/core/shared_widgets/custom_scaffold.dart';
import 'package:engzly/core/theming/colors.dart';
import 'package:engzly/core/theming/fonts.dart';
import 'package:engzly/core/theming/images.dart';
import 'package:engzly/features/services/cleaning/ui/cleaning/second_screen/widgets/cleaning_calender_widget.dart'
    show CleaningCalenderWidget;
import 'package:engzly/features/services/cleaning/ui/cleaning/third_screen/cleaning_choose_location.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:engzly/features/services/cleaning/logic/cleaning_cubit.dart';
import 'package:engzly/features/services/cleaning/ui/cleaning/second_screen/widgets/cleaning_calender_widget.dart';

class CleaningScheduleScreen extends StatelessWidget {
  const CleaningScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cleaningCubit = context.read<CleaningCubit>();

    return CustomScaffoldScreen(
      title: Text(
        "Schedule Cleaning",
        style: AppFonts.font14BWhiteWeight700.copyWith(fontSize: 18.sp),
      ),
      leadingIcon:
          SvgPicture.asset(AppImages.backArrow, width: 30.w, height: 30.h),
      notificationIcon:
          Image.asset(AppImages.notificationIcon, width: 28.w, height: 28.h),
      onLeadingTap: () => Navigator.pop(context),
      onNotificationTap: () {},
      showNotificationDot: true,
      child: Column(
        children: [
          20.verticalSpace,
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: CleaningCalenderWidget(
              onDateSelected: (selectedDate) {
                cleaningCubit.selectDate(selectedDate);
              },
            ),
          ),
          300.verticalSpace,
          CustomButton(
            borderRadius: 15.r,
            height: 50.h,
            width: 300.w,
            onPressed: () {
              if (cleaningCubit.selectedDate == null) {
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
                      BlocProvider.value(value: cleaningCubit),
                    ],
                    child: CleaningChooseLocation(),
                  ),
                ),
              );
            },
            text: "Proceed",
            color: ColorsManager.green,
            textStyle: AppFonts.font14BWhiteWeight700,
          ),
        ],
      ),
    );
  }
}
