import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ImageWidget extends StatelessWidget {
  const ImageWidget({super.key, required this.image, required this.onSkip});

  final String image;
  final VoidCallback? onSkip;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(image),
        Positioned(
          top: 45.h,
          right: 32.w,
          child: GestureDetector(
            onTap: onSkip,
            child: Container(width: 60, height: 35, color: Colors.transparent),
          ),
        ),
      ],
    );
  }
}
