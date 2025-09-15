import 'package:engzly/core/routing/route_name.dart';
import 'package:engzly/core/shared_widgets/custom_botton.dart';
import 'package:engzly/core/shared_widgets/custom_scaffold.dart';
import 'package:engzly/core/theming/colors.dart';
import 'package:engzly/core/theming/fonts.dart';
import 'package:engzly/core/theming/images.dart';
import 'package:engzly/features/profile/ui/location/my_location/widgets/location_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class MyLocation extends StatelessWidget {
  const MyLocation({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldScreen(
      showNotificationDot: true,
      title: Text(
        "My Locations",
        style: AppFonts.font14BWhiteWeight700.copyWith(fontSize: 18.sp),
      ),
      leadingIcon:
          SvgPicture.asset(AppImages.categoryIcon, width: 22.w, height: 22.h),
      notificationIcon:
          Image.asset(AppImages.notificationIcon, width: 28.w, height: 28.h),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    40.verticalSpace,
                    LocationCard(
                      title: "Cairo, Egypt",
                      address: "Al Qanater El Khayria 123 st",
                      onTap: () {},
                    ),
                    10.verticalSpace,
                    LocationCard(
                      title: "Giza, Egypt",
                      address: "Dokki 45 st",
                      onTap: () {},
                    ),
                    10.verticalSpace,
                    LocationCard(
                      title: "Alexandria, Egypt",
                      address: "Corniche Road 22 st",
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ),
            20.verticalSpace,
            CustomButton(
              height: 50.h,
              backgroundColor: ColorsManager.orange,
              color: ColorsManager.orange,
              borderRadius: 25.r,
              onPressed: () {
                Navigator.pushNamed(context, RouteName.addLocation);
              },
              child: Text(
                "Add New Location",
                style: AppFonts.font14BWhiteWeight700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
