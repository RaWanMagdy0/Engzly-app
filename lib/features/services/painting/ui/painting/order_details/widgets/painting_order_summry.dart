import 'package:engzly/core/theming/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PaintingOrderSummry extends StatelessWidget {
  final String label;
  final String value;
  final bool isTotal;
  final bool isDiscount;

  const PaintingOrderSummry({
    super.key,
    required this.label,
    required this.value,
    this.isTotal = false,
    this.isDiscount = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: isTotal ? 16.sp : 14.sp,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.w500,
              color: isTotal ? Colors.black : Colors.grey.shade700,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: isDiscount
                  ? 16.sp
                  : isTotal
                      ? 18.sp
                      : 14.sp,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.w600,
              color: isDiscount
                  ? ColorsManager.red
                  : isTotal
                      ? ColorsManager.yellow
                      : Colors.grey.shade800,
            ),
          ),
        ],
      ),
    );
  }
}
