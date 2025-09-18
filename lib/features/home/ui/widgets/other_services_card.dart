import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class OtherServiceCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final bool isNew;

  const OtherServiceCard({
    super.key,
    required this.imageUrl,
    required this.title,
    this.isNew = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            CircleAvatar(
              radius: 35.r,
              backgroundColor: Colors.grey.shade200,
              backgroundImage: NetworkImage(imageUrl),
            ),
            if (isNew)
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: const Text(
                    "New",
                    style: TextStyle(color: Colors.white, fontSize: 10),
                  ),
                ),
              )
          ],
        ),
        6.verticalSpace,
        SizedBox(
          width: 80.w,
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
  

}

