import 'package:engzly/core/theming/colors.dart';
import 'package:engzly/features/offers/ui/widgets/just_for_you.dart';
import 'package:engzly/features/offers/ui/widgets/latest_offers.dart';
import 'package:engzly/features/offers/ui/widgets/limited_offers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../core/shared_widgets/custom_scaffold.dart';
import '../../../core/theming/fonts.dart';
import '../../../core/theming/images.dart';

class OffersScreen extends StatelessWidget {
  const OffersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldScreen(
      title: Text(
        "Offers",
      ),
      leadingIcon: SvgPicture.asset(
        AppImages.categoryIcon,
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
      onLeadingTap: () {},
      onNotificationTap: () {},
      showNotificationDot: true,
      child: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            20.verticalSpace,
            LatestOffers(),
            25.verticalSpace,
            LimitedOffer(),
            25.verticalSpace,
            JustForYou(),
            25.verticalSpace,
          ],
        ),
      ),
    );
  }
}
