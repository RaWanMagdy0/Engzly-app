import 'package:engzly/features/history/ui/widgets/card_map.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../core/shared_widgets/custom_scaffold.dart';
import '../../../core/theming/fonts.dart';
import '../../../core/theming/images.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldScreen(
      title: Text(
        "History",
        style: AppFonts.font14BWhiteWeight700.copyWith(fontSize: 18.sp),
      ),
      leadingIcon:
      SvgPicture.asset(AppImages.categoryIcon, width: 22.w, height: 22.h),
      notificationIcon:
      Image.asset(AppImages.notificationIcon, width: 28.w, height: 28.h),
      onLeadingTap: () {},
      onNotificationTap: () {},
      showNotificationDot: true,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: const [
            ServiceCardMap(
              status: "Active",
              title: "House Shifting Service",
              date: "Friday, May 11, 2021",
              address: "3329 Joyce Stree, PA, USA",
              location: LatLng(40.7128, -74.0060),
            ),
            ServiceCardMap(
              status: "Cancelled",
              title: "Painting Service",
              date: "Friday, May 11, 2021",
              address: "3329 Joyce Stree, PA, USA",
              location: LatLng(34.0522, -118.2437),
            ),
            ServiceCardMap(
              status: "Done",
              title: "Cleaning Service",
              date: "Sunday, January 03, 2021",
              address: "3329 Joyce Stree, PA, USA",
              location: LatLng(51.5074, -0.1278),
            ),
          ],
        ),
      ),
    );
  }}