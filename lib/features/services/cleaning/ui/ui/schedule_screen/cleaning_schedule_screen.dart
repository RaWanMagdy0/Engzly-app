import 'package:engzly/core/shared_widgets/custom_botton.dart';
import 'package:engzly/core/shared_widgets/custom_scaffold.dart';
import 'package:engzly/core/theming/colors.dart';
import 'package:engzly/core/theming/fonts.dart';
import 'package:engzly/core/theming/images.dart';
import 'package:engzly/features/services/cleaning/ui/ui/schedule_screen/widgets/cleaning_calender_widget.dart';
import 'package:engzly/features/services/cleaning/ui/ui/location_screen/cleaning_choose_location.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:engzly/features/services/cleaning/logic/cleaning_cubit.dart';

class CleaningScheduleScreen extends StatefulWidget {
  const CleaningScheduleScreen({super.key});

  @override
  State<CleaningScheduleScreen> createState() => _CleaningScheduleScreenState();
}

class _CleaningScheduleScreenState extends State<CleaningScheduleScreen> {
  bool _isSnackBarVisible = false;

  void _showSnackBar(String message) {
    setState(() => _isSnackBarVisible = true);

    ScaffoldMessenger.of(context)
        .showSnackBar(
          SnackBar(content: Text(message)),
        )
        .closed
        .then((_) {
      if (mounted) {
        setState(() => _isSnackBarVisible = false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final cleaningCubit = context.read<CleaningCubit>();

    return PopScope(
      canPop: !_isSnackBarVisible,
      onPopInvoked: (didPop) {
        if (!didPop && _isSnackBarVisible) {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        }
      },
      child: CustomScaffoldScreen(
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
        onLeadingTap: () {
          if (_isSnackBarVisible) {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          } else {
            Navigator.pop(context);
          }
        },
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
                    _showSnackBar('Please select a date first');
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
      ),
    );
  }
}