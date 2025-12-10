import 'package:engzly/core/shared_widgets/custom_botton.dart';
import 'package:engzly/core/shared_widgets/custom_scaffold.dart';
import 'package:engzly/core/theming/colors.dart';
import 'package:engzly/core/theming/fonts.dart';
import 'package:engzly/core/theming/images.dart';
import 'package:engzly/features/services/car_washer/ui/car_washer_location/car_wash_locations.dart';
import 'package:engzly/features/services/car_washer/ui/car_washer_schedule/widgets/car_washer_calender.dart'
    show CarWasherCalender;
import 'package:engzly/features/services/car_washer/ui/car_washer_schedule/widgets/select_time.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class CarWasherScheuleScreen extends StatefulWidget {
  const CarWasherScheuleScreen({super.key});

  @override
  State<CarWasherScheuleScreen> createState() => _CarWasherScheuleScreen();
}

class _CarWasherScheuleScreen extends State<CarWasherScheuleScreen> {
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
    return PopScope(
      canPop: !_isSnackBarVisible,
      onPopInvoked: (didPop) {
        if (!didPop && _isSnackBarVisible) {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        }
      },
      child: CustomScaffoldScreen(
        title: const Text("Date & Time"),
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
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              CarWasherCalender(
                onDateSelected: (selectedDate) {
                  //    cleaningCubit.selectDate(selectedDate);
                },
              ),
              SizedBox(height: 20),
              SelectTime(
                onTimeSelected: (slot) {
                  print("Selected time: $slot");
                },
              ),
              80.verticalSpace,
              CustomButton(
                borderRadius: 15.r,
                height: 50.h,
                width: 300.w,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const CarWashLocations()));
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
