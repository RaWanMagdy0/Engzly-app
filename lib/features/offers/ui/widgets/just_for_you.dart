import 'package:engzly/core/theming/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class JustForYou extends StatelessWidget {
  const JustForYou({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> cardImages = [
      AppImages.save30,
      AppImages.save30,
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Just For You",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        10.verticalSpace,
        SizedBox(
          height: 180.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: cardImages.length,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.only(right: 15.w),
                width: 150.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: SvgPicture.asset(cardImages[index]),
              );
            },
          ),
        ),
      ],
    );
  }
}
