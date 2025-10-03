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
        CircleAvatar(
          radius: 35.r,
          backgroundColor: Colors.grey.shade200,
          backgroundImage: NetworkImage(imageUrl),
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
