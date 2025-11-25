import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SquareOfferCard extends StatelessWidget {
  final dynamic offer;
  final VoidCallback? onTap;
  final List<Color> gradient;

  const SquareOfferCard({
    super.key,
    required this.offer,
    this.onTap,
    required this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
          width: 300.w,
          height: 200.h,
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: gradient,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${offer.percentage.toInt()}% OFF",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      offer.title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    GestureDetector(
                      onLongPress: () {
                        Clipboard.setData(ClipboardData(text: offer.promoCode));
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Promo code copied!")),
                        );
                      },
                      child: Row(
                        children: [
                          Text(
                            "Code:",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(width: 2.h),
                          Text(
                            offer.promoCode,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w700,
                            ),
                            softWrap: true,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              if (offer.icon.isNotEmpty)
                SizedBox(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.r),
                    child: Image.network(
                      offer.icon,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
            ],
          ),
        ));
  }
}
