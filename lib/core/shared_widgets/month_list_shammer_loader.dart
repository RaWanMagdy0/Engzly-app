import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MonthListShammerLoader extends StatelessWidget {
  const MonthListShammerLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30.h,
      child: ListView.builder(
        itemCount: 5,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: Padding(
              padding: EdgeInsets.only(left: 12.w),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 1000),
                width: 90.w,
                height: 30.h,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(18.r),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
