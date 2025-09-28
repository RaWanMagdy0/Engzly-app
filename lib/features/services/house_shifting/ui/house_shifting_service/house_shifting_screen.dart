import 'package:engzly/core/shared_widgets/custom_botton.dart';
import 'package:engzly/core/shared_widgets/custom_scaffold.dart';
import 'package:engzly/core/theming/colors.dart';
import 'package:engzly/core/theming/fonts.dart';
import 'package:engzly/core/theming/images.dart' show AppImages;
import 'package:engzly/features/services/house_shifting/ui/house_shifting_service/widgets/furniture_section.dart';
import 'package:engzly/features/services/house_shifting/ui/house_shifting_service/widgets/house_header_section.dart';
import 'package:engzly/features/services/house_shifting/ui/house_shifting_service/widgets/house_option_section.dart';
import 'package:engzly/features/services/house_shifting/ui/house_shifting_service/widgets/packed_boxes_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class HouseShiftingScreen extends StatelessWidget {
  const HouseShiftingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldScreen(
      title: Text(
        "House Shifting Service",
        style: AppFonts.font14BWhiteWeight700.copyWith(fontSize: 18.sp),
      ),
      leadingIcon:
          SvgPicture.asset(AppImages.categoryIcon, width: 22.w, height: 22.h),
      notificationIcon:
          Image.asset(AppImages.notificationIcon, width: 28.w, height: 28.h),
      onLeadingTap: () {},
      onNotificationTap: () {},
      showNotificationDot: true,
      child: SingleChildScrollView(
        child: Column(
          children: [
            const HouseHeaderSection(),
            const HouseOptionsSection(),
            Container(
                color: ColorsManager.lightGray,
                width: double.infinity,
                height: 15.h),
            const FurnitureSection(),
            Container(
                color: ColorsManager.lightGray,
                width: double.infinity,
                height: 15.h),
            const PackedBoxesCard(),
            CustomButton(
              borderRadius: 15.r,
              height: 50.h,
              width: 300.w,
              onPressed: () {},
              text: "Procces",
              color: ColorsManager.orange,
              textStyle: AppFonts.font14BWhiteWeight700,
            ),
            20.verticalSpace,
          ],
        ),
      ),
    );
  }
}
