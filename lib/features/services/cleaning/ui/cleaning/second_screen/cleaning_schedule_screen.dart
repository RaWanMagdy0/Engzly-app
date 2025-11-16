import 'package:engzly/core/shared_widgets/custom_botton.dart';
import 'package:engzly/core/shared_widgets/custom_scaffold.dart';
import 'package:engzly/core/theming/colors.dart';
import 'package:engzly/core/theming/fonts.dart';
import 'package:engzly/core/theming/images.dart';
import 'package:engzly/features/services/cleaning/ui/cleaning/second_screen/widgets/cleaning_calender_widget.dart';
import 'package:engzly/features/services/cleaning/ui/cleaning/third_screen/cleaning_choose_location.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:engzly/features/services/cleaning/logic/cleaning_cubit.dart';

class CleaningScheduleScreen extends StatelessWidget {
  const CleaningScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cleaningCubit = context.read<CleaningCubit>();

    return CustomScaffoldScreen(
      title: const Text("Schedule Cleaning"),
      leadingIcon: SvgPicture.asset(
        AppImages.backArrow,
        width: 30.w,
        height: 30.h,
        color: ColorsManager.black,
      ),
      notificationIcon: Image.asset(
        AppImages.notificationIcon,
        width: 28.w,
        height: 28.h,
        color: ColorsManager.black,
      ),
      onLeadingTap: () => Navigator.pop(context),
      onNotificationTap: () {},
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CleaningCalenderWidget(
              onDateSelected: (selectedDate) {
                cleaningCubit.selectDate(selectedDate);
              },
            ),
            const Spacer(),
            CustomButton(
              borderRadius: 15.r,
              height: 50.h,
              width: 300.w,
              onPressed: () {
                if (cleaningCubit.selectedDate == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please select a date first'),
                    ),
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
                      child: const CleaningChooseLocation(),
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
      ),
    );
  }
}
