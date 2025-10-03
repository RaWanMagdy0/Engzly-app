import 'package:engzly/core/routing/route_name.dart';
import 'package:engzly/core/shared_widgets/custom_botton.dart';
import 'package:engzly/core/shared_widgets/custom_scaffold.dart';
import 'package:engzly/core/theming/colors.dart';
import 'package:engzly/core/theming/fonts.dart';
import 'package:engzly/core/theming/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ChooseLocation extends StatelessWidget {
  const ChooseLocation({super.key});

  @override
  Widget build(BuildContext context) {
    const LatLng initialLocation = LatLng(30.0444, 31.2357);

    return CustomScaffoldScreen(
        title: Text(
          "Location",
          style: AppFonts.font14BWhiteWeight700.copyWith(fontSize: 18.sp),
        ),
        leadingIcon:
            SvgPicture.asset(AppImages.categoryIcon, width: 22.w, height: 22.h),
        notificationIcon:
            Image.asset(AppImages.notificationIcon, width: 28.w, height: 28.h),
        onLeadingTap: () {},
        onNotificationTap: () {},
        showNotificationDot: true,
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 600.h,
              child: GoogleMap(
                initialCameraPosition: const CameraPosition(
                  target: initialLocation,
                  zoom: 14,
                ),
                markers: {
                  const Marker(
                    markerId: MarkerId("default"),
                    position: initialLocation,
                    infoWindow: InfoWindow(title: "Static Marker"),
                  ),
                },
                myLocationEnabled: false,
                myLocationButtonEnabled: false,
                zoomControlsEnabled: false,
                onTap: (_) {},
                onCameraMove: (_) {},
              ),
            ),
          ),
          CustomButton(
            borderRadius: 15.r,
            height: 50.h,
            width: 300.w,
            onPressed: () {
              Navigator.pushNamed(context, RouteName.orderConfirmation);
            },
            text: "Process",
            color: ColorsManager.orange,
            textStyle: AppFonts.font14BWhiteWeight700,
          ),
        ]));
  }
}
