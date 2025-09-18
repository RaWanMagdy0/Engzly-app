import 'package:engzly/core/theming/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OfferCard extends StatelessWidget {
  final String title;
  final String discountText;
  final String image;
  final Color color;

  const OfferCard({
    super.key,
    required this.title,
    required this.discountText,
    required this.image,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    Widget imageWidget;
    if (image.isNotEmpty &&
        (image.startsWith('http') || image.startsWith('https'))) {
      imageWidget = Image.network(
        image,
        width: 80.w,
        height: 80.h,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => SizedBox(
          width: 80.w,
          height: 80.h,
          child: Icon(Icons.broken_image, size: 32.sp),
        ),
      );
    } else if (image.isNotEmpty) {
      imageWidget = Image.asset(
        image,
        width: 80.w,
        height: 80.h,
        fit: BoxFit.contain,
      );
    } else {
      imageWidget = SizedBox(
        width: 80.w,
        height: 80.h,
        child: Icon(Icons.image, size: 32.sp),
      );
    }

    return Container(
      width: 260.w,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        gradient: LinearGradient(
          colors: [color.withOpacity(0.85), color],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: AppFonts.font14BWhiteWeight700.copyWith(
                      color: Colors.white,
                      fontSize: 16.sp,
                    )),
                10.verticalSpace,
                Text(discountText,
                    style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
              ],
            ),
          ),
          imageWidget,
        ],
      ),
    );
  }
}
