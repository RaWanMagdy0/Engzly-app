import 'package:engzly/core/shared_widgets/custom_botton.dart';
import 'package:engzly/core/shared_widgets/custom_scaffold.dart';
import 'package:engzly/core/theming/colors.dart';
import 'package:engzly/core/theming/fonts.dart';
import 'package:engzly/core/theming/images.dart';
import 'package:engzly/features/services/car_washer/ui/car_washer_location/add_new_locarion.dart';
import 'package:engzly/features/services/car_washer/ui/car_washer_location/widgets/wash_location_card.dart';
import 'package:engzly/features/services/car_washer/ui/order_details.dart/order_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class CarWashLocations extends StatefulWidget {
  const CarWashLocations({super.key});

  @override
  State<CarWashLocations> createState() => _CarWashLocationsState();
}

class _CarWashLocationsState extends State<CarWashLocations> {
  int selectedIndex = -1;
  @override
  Widget build(BuildContext context) {
    return CustomScaffoldScreen(
      title: Text("Choose Locations"),
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
        children: [
          20.verticalSpace,
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.all(16.w),
              itemCount: 3,
              separatorBuilder: (_, __) => 15.verticalSpace,
              itemBuilder: (context, index) {
                return WashLocationCard(
                  title: "Home",
                  address: "Cairo, Egypt",
                  isSelected: index == selectedIndex,
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  onEdit: () {},
                  onDelete: () {},
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
            child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const AddNewLocation()));
                },
                child: Container(
                  width: double.infinity,
                  height: 130.h,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14.r),
                    border: Border.all(
                      color: Colors.grey.shade300,
                      width: 2,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add_circle_outline, size: 40),
                      SizedBox(height: 10),
                      Text(
                        "New Location",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                )),
          ),
          CustomButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const OrderDetailsScreen()));
            },
            color: ColorsManager.green,
            textStyle: AppFonts.font14BWhiteWeight700,
            height: 55.h,
            width: 300.w,
            borderRadius: 25.r,
            child: Text("Process", style: AppFonts.font14BWhiteWeight700),
          ),
          20.verticalSpace,
        ],
      ),
    );
  }
}
