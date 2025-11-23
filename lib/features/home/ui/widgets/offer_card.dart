import 'package:engzly/features/home/data/models/offers/offer_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OfferCard extends StatelessWidget {
  final OfferModel offer;

  const OfferCard({
    super.key,
    required this.offer,
  });

  @override
  Widget build(BuildContext context) {
    final gradients = [
      [Color(0xffA874F1), Color(0xffC084FC)],
      [Color(0xffFF8C42), Color(0xffFFB36A)],
      [Color(0xff4CC9F0), Color(0xff72E3FF)],
      [Color(0xffFF6B6B), Color(0xffFF8E8E)],
      [Color.fromRGBO(107, 203, 119, 1), Color(0xff95E8A1)],
    ];

    final randomIndex = offer.id % gradients.length;

    return Container(
      width: 240.w,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradients[randomIndex],
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
          /******  if (offer.icon.isNotEmpty)
            Expanded(
              child: SizedBox(
                width: 100.w,
                height: 100.h,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.r),
                  child: Image.network(
                    offer.icon,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),*/
        ],
      ),
    );
  }
}
