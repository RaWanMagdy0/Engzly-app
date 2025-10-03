import 'package:engzly/core/routing/route_name.dart';
import 'package:engzly/core/shared_widgets/custom_botton.dart';
import 'package:engzly/core/shared_widgets/custom_scaffold.dart';
import 'package:engzly/core/theming/colors.dart';
import 'package:engzly/core/theming/fonts.dart';
import 'package:engzly/core/theming/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';

class OrderConfirmation extends StatelessWidget {
  const OrderConfirmation({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldScreen(
        title: Text(
          "Order Confirmation",
          style: AppFonts.font14BWhiteWeight700.copyWith(fontSize: 18.sp),
        ),
        leadingIcon:
            SvgPicture.asset(AppImages.categoryIcon, width: 22.w, height: 22.h),
        notificationIcon:
            Image.asset(AppImages.notificationIcon, width: 28.w, height: 28.h),
        onLeadingTap: () {},
        onNotificationTap: () {},
        showNotificationDot: true,
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          SizedBox(
            height: 300.h,
            width: 200.w,
            child: Lottie.asset(
              AppImages.submitCheck,
            ),
          ),
          Text("order Placed ", style: AppFonts.font36BlackWeight700),
          5.verticalSpace,
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: AppFonts.font16BlackWeight400,
              children: [
                TextSpan(
                  text:
                      "Your order has been Successfully placed, Our logistic team will contact with you soon. For any help, call ",
                ),
                TextSpan(
                  text: "(+1) 999 999 999",
                  style: AppFonts.font14BOrangeWeight400,
                ),
              ],
            ),
          ),
          40.verticalSpace,
          Container(
            width: double.infinity,
            height: 2.h,
            color: Colors.grey.shade200,
          ),
          20.verticalSpace,
          Text("SCHEDULE", style: AppFonts.font16BlackWeight400),
          10.verticalSpace,
          Text("Friday, May 11, 2021 @ 8 AM",
              style: AppFonts.font16BlackWeight400),
          40.verticalSpace,
          Container(
            width: double.infinity,
            height: 2.h,
            color: Colors.grey.shade200,
          ),
          50.verticalSpace,
          CustomButton(
            borderRadius: 15.r,
            height: 50.h,
            width: 300.w,
            onPressed: () {
              Navigator.pushNamed(context, RouteName.homeLayout);
            },
            text: "Go to Homepage",
            color: ColorsManager.orange,
            textStyle: AppFonts.font14BWhiteWeight700,
          ),
        ]));
  }
}
