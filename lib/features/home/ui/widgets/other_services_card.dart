import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OtherServiceCard extends StatelessWidget {
  final String title;
  final String iconPath;
  final Color backgroundColor;
  final VoidCallback? onTap;

  const OtherServiceCard(
      {super.key,
      required this.title,
      required this.iconPath,
      required this.backgroundColor,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: _buildIcon(),
        ),
        SizedBox(
          width: 80.w,
          child: Text(
            title,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w700,
              color: Colors.black87,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildIcon() {
    return Image.network(
      iconPath,
      height: 70.h,
      width: 70.w,
      errorBuilder: (_, __, ___) => Icon(Icons.broken_image, size: 50.sp),
    );
  }
}
