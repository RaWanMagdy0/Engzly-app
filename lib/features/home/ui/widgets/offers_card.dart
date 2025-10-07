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
      imageWidget = ClipRRect(
        borderRadius: BorderRadius.circular(16.r),
        child: Image.network(
          image,
          width: 260.w,
          height: 150.h,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => Container(
            width: 260.w,
            height: 150.h,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Icon(Icons.broken_image, size: 48.sp, color: Colors.grey),
          ),
        ),
      );
    } else if (image.isNotEmpty) {
      imageWidget = ClipRRect(
        borderRadius: BorderRadius.circular(16.r),
        child: Image.asset(
          image,
          width: 260.w,
          height: 150.h,
          fit: BoxFit.contain,
        ),
      );
    } else {
      imageWidget = Container(
        width: 260.w,
        height: 150.h,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Icon(Icons.image, size: 48.sp, color: Colors.grey),
      );
    }

    return imageWidget;
  }
}