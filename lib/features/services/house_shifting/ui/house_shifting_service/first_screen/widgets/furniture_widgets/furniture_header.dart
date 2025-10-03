import 'package:engzly/core/theming/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FurnitureHeader extends StatelessWidget {
  final int furnituresCount;

  const FurnitureHeader({super.key, required this.furnituresCount});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Furnitures",
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        TextButton(
          style: ButtonStyle(
            backgroundColor:
                WidgetStateProperty.all<Color>(Colors.grey.shade100),
            padding: WidgetStateProperty.all(
              EdgeInsets.symmetric(horizontal: 20.w, vertical: 4.h),
            ),
          ),
          onPressed: () {},
          child: Text("$furnituresCount Item  x",
              style: AppFonts.font20BlackWeight700.copyWith(
                fontSize: 12.sp,
              )),
        ),
      ],
    );
  }
}
