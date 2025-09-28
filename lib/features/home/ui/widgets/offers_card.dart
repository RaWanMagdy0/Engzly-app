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

    return Row(
      children: [
        imageWidget,
      ],
    );
  }
}
