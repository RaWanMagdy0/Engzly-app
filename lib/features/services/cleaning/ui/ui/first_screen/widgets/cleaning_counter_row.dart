import 'package:engzly/core/theming/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class CounterRow extends StatelessWidget {
  final String title;
  final String subtitle;
  final String iconPath;
  final int value;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const CounterRow({
    super.key,
    required this.title,
    required this.subtitle,
    required this.iconPath,
    required this.value,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(14.sp),
      child: Row(
        children: [
          Container(
            width: 65.w,
            height: 65.h,
            decoration: BoxDecoration(
              color: Colors.grey.withValues(alpha: .1),
              shape: BoxShape.circle,
            ),
            child: Padding(
              padding: EdgeInsets.all(12),
              child: SvgPicture.asset(
                iconPath,
              ),
            ),
          ),
          12.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: AppFonts.font16BlackWeight400
                        .copyWith(fontWeight: FontWeight.w700)),
                4.verticalSpace,
                Text(
                  subtitle,
                  style: AppFonts.font16BlackWeight400
                      .copyWith(color: Colors.grey.shade500, fontSize: 14.sp),
                ),
              ],
            ),
          ),
          10.horizontalSpace,
          Row(
            children: [
              _buildCounterButton(Icons.remove, onDecrement),
              10.horizontalSpace,
              Text(
                value.toString(),
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              10.horizontalSpace,
              _buildCounterButton(Icons.add, onIncrement),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCounterButton(IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8.r),
      child: Container(
        width: 28.w,
        height: 28.h,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Icon(icon, size: 18, color: Colors.black),
      ),
    );
  }
}
