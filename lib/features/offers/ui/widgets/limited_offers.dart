import 'package:engzly/core/theming/images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class LimitedOffer extends StatelessWidget {
  const LimitedOffer({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> cardImages = [
      AppImages.truck,
      AppImages.truck,

//"assets/images/ima.png",
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Limited Offer",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        10.verticalSpace,
        SizedBox(
          height: 150.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: cardImages.length,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.only(right: 12.w),
                width: 300.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: SvgPicture.asset(cardImages[index]),
              );
            },
          ),
        ),
      ],
    );
  }
}
