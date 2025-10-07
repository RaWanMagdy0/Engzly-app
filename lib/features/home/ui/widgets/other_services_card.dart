import 'package:engzly/core/theming/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OtherServiceCard extends StatelessWidget {
  final String title;
  final String iconPath;
  final Color backgroundColor;

  const OtherServiceCard({
    super.key,
    required this.title,
    required this.iconPath,
    required this.backgroundColor,
  });

  static final List<Map<String, dynamic>> staticServices = [
    {
      'title': 'Cleaning',
      'iconPath': AppImages.cleaningIcon,
      'backgroundColor': const Color(0xFFF0FAF2).withValues(alpha: 0.7),
    },
    {
      'title': 'Labour Service',
      'iconPath': AppImages.labourIcon,
      'backgroundColor': const Color(0xFFE5F3FB).withValues(alpha: 0.74),
    },
    {
      'title': 'Vehicle',
      'iconPath': AppImages.vehicleIcon,
      'backgroundColor': const Color(0xFFF4EAFB).withValues(alpha: 0.74),
    },
    {
      'title': 'Painting',
      'iconPath': AppImages.paintingIcon,
      'backgroundColor': const Color(0xFFFFE5EA).withValues(alpha: 0.74),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 75.w,
          height: 75.h,
          decoration: BoxDecoration(
            color: backgroundColor,
            shape: BoxShape.circle,
          ),
          child: Padding(
            padding: EdgeInsets.all(12.w),
            child: _buildIcon(),
          ),
        ),
        5.verticalSpace,
        SizedBox(
          width: 80.w,
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildIcon() {
    return Image.asset(
      iconPath,
      fit: BoxFit.contain,
    );
  }
}
