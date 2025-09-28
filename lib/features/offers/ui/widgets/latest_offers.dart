import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LatestOffers extends StatelessWidget {
  const LatestOffers({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> cardImages = [
      "assets/images/ima.png",
      "assets/images/ima.png",
      "assets/images/ima.png",
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Latest Offers",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        10.verticalSpace,

        SizedBox(
          height: 160.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: cardImages.length,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.only(right: 12.w),
                width: 260.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.r),
                  image: DecorationImage(
                    image: AssetImage(cardImages[index]),
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
