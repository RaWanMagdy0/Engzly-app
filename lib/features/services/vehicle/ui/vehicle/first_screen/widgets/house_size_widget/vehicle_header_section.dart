import 'package:engzly/core/theming/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:engzly/core/theming/fonts.dart';
import 'package:engzly/core/theming/colors.dart';

class VehicleHeaderSection extends StatelessWidget {
  const VehicleHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          20.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset(
                    AppImages.vehicleIcon,
                    color: ColorsManager.orange,
                  ),
                  Text("Vehicle", style: AppFonts.font36BlackWeight700),
                ],
              ),
              TextButton.icon(
                style: ButtonStyle(
                  backgroundColor:
                      WidgetStateProperty.all<Color>(Colors.grey.shade100),
                ),
                onPressed: () {},
                icon: const Icon(Icons.add, color: ColorsManager.orange),
                label: Text("Custom",
                    style: AppFonts.font14BOrangeWeight400.copyWith(
                        fontWeight: FontWeight.w700,
                        color: ColorsManager.orange)),
              ),
            ],
          ),
          10.verticalSpace,
          Text(
            "Choose vehicle type as your need, we’ll calculate the cost for you.",
            style: AppFonts.font16BlackWeight400
                .copyWith(color: Colors.grey.shade500),
          ),
        ],
      ),
    );
  }
}
