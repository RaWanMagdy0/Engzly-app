import 'package:engzly/core/theming/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:engzly/core/theming/fonts.dart';
import 'package:engzly/core/theming/colors.dart';
import 'package:flutter_svg/svg.dart';

class PaintingHeaderSection extends StatelessWidget {
  const PaintingHeaderSection({super.key});

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
                  SvgPicture.asset(AppImages.paintign),
                  5.horizontalSpace,
                  Text("Painting", style: AppFonts.font36BlackWeight700),
                ],
              ),
              TextButton.icon(
                style: ButtonStyle(
                  backgroundColor:
                      WidgetStateProperty.all<Color>(Colors.grey.shade100),
                ),
                onPressed: () {},
                icon: const Icon(Icons.add, color: ColorsManager.yellow),
                label: Text("Custom",
                    style: AppFonts.font14BOrangeWeight400.copyWith(
                        fontWeight: FontWeight.w700,
                        color: ColorsManager.yellow)),
              ),
            ],
          ),
          10.verticalSpace,
          Text(
            "Select your house rooms and kitchen in order to measure the total cost.",
            style: AppFonts.font16BlackWeight400
                .copyWith(color: Colors.grey.shade500),
          ),
        ],
      ),
    );
  }
}
