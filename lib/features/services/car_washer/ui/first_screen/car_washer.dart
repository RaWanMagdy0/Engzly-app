import 'package:engzly/core/routing/route_name.dart';
import 'package:engzly/core/shared_widgets/custom_botton.dart';
import 'package:engzly/core/shared_widgets/custom_scaffold.dart';
import 'package:engzly/core/theming/colors.dart';
import 'package:engzly/core/theming/fonts.dart';
import 'package:engzly/core/theming/images.dart';
import 'package:engzly/features/services/car_washer/ui/first_screen/widgets/add_new_vehicle_screen/add_new_vehicle_screen.dart';
import 'package:engzly/features/services/car_washer/ui/first_screen/widgets/vehicle_card.dart';
import 'package:engzly/features/services/car_washer/ui/first_screen/widgets/wash_service_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class CarWasher extends StatefulWidget {
  const CarWasher({super.key});

  @override
  State<CarWasher> createState() => _CarWasherState();
}

class _CarWasherState extends State<CarWasher> {
  int selectedVehicleIndex = 1;
  int selectedServiceIndex = -1;

  final List<Map<String, String>> vehicles = [
    {"image": AppImages.car, "title": "Mercedes", "subtitle": "subtitle"},
    {"image": AppImages.car, "title": "KIA", "subtitle": "subtitle"},
    {"image": AppImages.car, "title": "SUV", "subtitle": "subtitle"},
    {"image": AppImages.car, "title": "Hyundai", "subtitle": "subtitle"},
    {"image": AppImages.car, "title": "BMW", "subtitle": "subtitle"},
  ];

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldScreen(
      title: Text("Car Washing"),
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
        Navigator.pop(context);
      },
      onNotificationTap: () {},
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  5.verticalSpace,
                  Text("Vehicles", style: AppFonts.font20BlackWeight700),
                  10.verticalSpace,
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        for (int i = 0; i < vehicles.length; i++) ...[
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedVehicleIndex = i;
                              });
                            },
                            child: VehicleCard(
                              imagePath: vehicles[i]["image"]!,
                              title: vehicles[i]["title"]!,
                              subtitle: vehicles[i]["subtitle"]!,
                              isSelected: selectedVehicleIndex == i,
                            ),
                          ),
                          SizedBox(width: 12),
                        ],
                        10.horizontalSpace,
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => AddNewVehicleScreen()),
                            );
                          },
                          child: Container(
                            width: 120.w,
                            height: 150.h,
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
                                  "New",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  20.verticalSpace,
                  Container(
                    height: 10.h,
                    width: double.infinity,
                    color: ColorsManager.lightGray,
                  ),
                  20.verticalSpace,
                  Text("Select Wash Package",
                      style: AppFonts.font20BlackWeight700),
                  10.verticalSpace,
                  WashServiceCard(
                    imagePath: AppImages.vehicleIcon,
                    title: "Quick wash",
                    time: "20 Minutes",
                    price: "400",
                    isSelected: selectedServiceIndex == 0,
                    onTap: () {
                      setState(() {
                        selectedServiceIndex = 0;
                      });
                    },
                  ),
                  WashServiceCard(
                    imagePath: AppImages.vehicleIcon,
                    title: "Regular Wash",
                    time: "35 Minutes",
                    price: "600",
                    isSelected: selectedServiceIndex == 1,
                    onTap: () {
                      setState(() {
                        selectedServiceIndex = 1;
                      });
                    },
                  ),
                  WashServiceCard(
                    imagePath: AppImages.vehicleIcon,
                    title: "Medium Wash",
                    time: "45 Minutes",
                    price: "800",
                    isSelected: selectedServiceIndex == 2,
                    onTap: () {
                      setState(() {
                        selectedServiceIndex = 2;
                      });
                    },
                  ),
                  WashServiceCard(
                    imagePath: AppImages.vehicleIcon,
                    title: "Special Wash",
                    time: "60 Minutes",
                    price: "1000",
                    isSelected: selectedServiceIndex == 3,
                    onTap: () {
                      setState(() {
                        selectedServiceIndex = 3;
                      });
                    },
                  ),
                  70.verticalSpace,
                ],
              ),
            ),
            Positioned(
              left: 30.w,
              right: 30.w,
              bottom: 7.h,
              child: CustomButton(
                borderRadius: 20.r,
                height: 50.h,
                onPressed: () {
                  Navigator.pushNamed(
                      context, RouteName.carWasherScheuleScreen);
                },
                text: "Proceed",
                color: ColorsManager.green,
                textStyle: AppFonts.font14BWhiteWeight700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
