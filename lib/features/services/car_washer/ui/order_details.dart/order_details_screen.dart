import 'package:engzly/core/shared_widgets/custom_botton.dart';
import 'package:engzly/core/shared_widgets/custom_scaffold.dart';
import 'package:engzly/core/theming/colors.dart';
import 'package:engzly/core/theming/fonts.dart';
import 'package:engzly/core/theming/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldScreen(
      title: Text("Order Details"),
      leadingIcon: SvgPicture.asset(
        AppImages.backArrow,
        width: 22.w,
        height: 22.h,
        color: ColorsManager.black,
      ),
      notificationIcon: Image.asset(
        AppImages.notificationIcon,
        width: 28.w,
        height: 28.h,
        color: ColorsManager.black,
      ),
      onLeadingTap: () {
        Navigator.pop(context);
      },
      onNotificationTap: () {},
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            20.verticalSpace,
            Align(
              alignment: Alignment.center,
              child: Text(
                "Order Details Here",
                style: AppFonts.font20BlackWeight700,
              ),
            ),
            CustomButton(
              onPressed: () {},
              color: ColorsManager.green,
              textStyle: AppFonts.font14BWhiteWeight700,
              height: 55.h,
              width: 300.w,
              borderRadius: 25.r,
              child:
                  Text("Confirm Order", style: AppFonts.font14BWhiteWeight700),
            ),
            20.verticalSpace,
          ]),
    );
  }
}
