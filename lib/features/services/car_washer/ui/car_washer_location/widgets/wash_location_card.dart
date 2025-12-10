import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WashLocationCard extends StatelessWidget {
  final String title;
  final String address;
  final IconData icon;
  final VoidCallback? onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final bool isSelected;

  const WashLocationCard({
    super.key,
    required this.title,
    required this.address,
    this.icon = Icons.location_city_sharp,
    this.onTap,
    this.onEdit,
    this.onDelete,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        width: double.infinity,
        height: 130.h,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: Colors.grey.shade300, width: 2),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 22.w,
              height: 22.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? Colors.green : Colors.grey,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? Center(
                      child: Container(
                        width: 12.w,
                        height: 12.h,
                        decoration: const BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                        ),
                      ),
                    )
                  : null,
            ),
            18.horizontalSpace,
            Icon(icon, color: Colors.black, size: 26.sp),
            16.horizontalSpace,
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 15.sp,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  8.verticalSpace,
                  Text(
                    address,
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 13.sp,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            10.horizontalSpace,
            Row(
              children: [
                InkWell(
                  onTap: onEdit,
                  child: Icon(Icons.edit, color: Colors.grey, size: 23.sp),
                ),
                14.horizontalSpace,
                InkWell(
                  onTap: onDelete,
                  child: Icon(Icons.delete_rounded,
                      color: Colors.red, size: 23.sp),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
