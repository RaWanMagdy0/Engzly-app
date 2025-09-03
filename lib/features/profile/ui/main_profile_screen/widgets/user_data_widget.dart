import 'package:engzly/core/routing/route_name.dart';
import 'package:engzly/core/theming/colors.dart';
import 'package:engzly/core/theming/fonts.dart';
import 'package:engzly/core/shared_widgets/custom_botton.dart';
import 'package:flutter/material.dart';
import 'package:engzly/core/theming/images.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class UserDataWidget extends StatelessWidget {
  const UserDataWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.transparent, width: 2.w),
              borderRadius: BorderRadius.circular(15.r),
            ),
            child: SvgPicture.asset(
              AppImages.profileIcon,
              width: 80.w,
              height: 80.h,
              colorFilter: ColorFilter.mode(
                ColorsManager.darkGray,
                BlendMode.srcIn,
              ),
            ),
          ),
          Text(
            "Rawan Magdy ",
            style: AppFonts.font20BlackWeight700.copyWith(fontSize: 18.sp),
          ),
          Text(
            "rawan.magdy.fahmy@gmail.com ",
            style: AppFonts.font14BOrangeWeight400,
          ),
          CustomButton(
            text: "Edit",
            onPressed: () {
              Navigator.pushReplacementNamed(context, RouteName.editProfile);
            },
            width: 100.w,
            height: 40.h,
            backgroundColor: ColorsManager.white,
            textStyle: AppFonts.font16BlackWeight400.copyWith(
              fontSize: 15.sp,
              fontWeight: FontWeight.w500,
            ),
            borderColor: ColorsManager.orange,
            borderRadius: 25.r,
          ),
        ],
      ),
    );
  }
}
