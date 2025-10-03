import 'package:engzly/core/routing/route_name.dart';
import 'package:engzly/core/shared_widgets/custom_scaffold.dart';
import 'package:engzly/core/theming/colors.dart';
import 'package:engzly/core/theming/fonts.dart';
import 'package:engzly/core/theming/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class QuestionsScreen extends StatelessWidget {
  const QuestionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final faqData = [
      {
        "category": "General",
        "questions": [
          {
            "q": "How to contact with riders?",
            "a":
                "You can contact your assigned rider directly via in-app chat or call option after booking is confirmed."
          },
          {
            "q": "How to change my selected furniture?",
            "a":
                "You can edit your furniture list from the order details before the rider has been assigned."
          },
          {
            "q": "What is cost of each item?",
            "a":
                "The cost depends on weight, size, and distance. You can check detailed pricing before confirming your booking."
          },
          {
            "q": "How can I track my shipment?",
            "a":
                "Your order can be tracked live using the in-app map once it is picked up."
          },
          {
            "q": "Do I need to provide packing material?",
            "a":
                "No, our logistics team provides necessary packing materials if requested."
          },
        ]
      },
      {
        "category": "Contact",
        "questions": [
          {
            "q": "What is the customer care number?",
            "a": "You can reach our support team 24/7 at (+1) 999 999 999."
          },
          {
            "q": "Can I cancel the order after one week?",
            "a":
                "Orders can be cancelled up to 24 hours before scheduled shifting. Later cancellations may have charges."
          },
          {
            "q": "How to call any service now?",
            "a":
                "Simply select the service from the home screen and place your request instantly."
          },
          {
            "q": "Do you offer 24/7 customer support?",
            "a":
                "Yes, our support is available around the clock for all your shifting needs."
          },
          {
            "q": "Can I change the delivery address after booking?",
            "a":
                "Yes, but additional charges may apply depending on the new location."
          },
        ]
      },
      {
        "category": "Payments",
        "questions": [
          {
            "q": "What payment methods do you accept?",
            "a":
                "We accept credit cards, debit cards, wallets, and cash on delivery."
          },
          {
            "q": "Is online payment secure?",
            "a":
                "Yes, all online payments are encrypted and processed securely."
          },
          {
            "q": "Do you provide invoice for business use?",
            "a":
                "Yes, invoices are automatically generated after each successful order."
          },
          {
            "q": "Can I pay partially before delivery?",
            "a": "Yes, partial payments are supported depending on the service."
          },
          {
            "q": "Are there any hidden charges?",
            "a":
                "No hidden charges. All costs are shown upfront before you confirm."
          },
        ]
      },
      {
        "category": "Services",
        "questions": [
          {
            "q": "Do you offer same-day shifting?",
            "a":
                "Yes, same-day services are available based on vehicle availability."
          },
          {
            "q": "Can I book multiple trucks in one order?",
            "a":
                "Yes, you can select multiple vehicles depending on your needs."
          },
          {
            "q": "Do you provide manpower for loading and unloading?",
            "a": "Yes, we provide professional movers to handle your goods."
          },
          {
            "q": "Can fragile items be moved safely?",
            "a":
                "Yes, we use protective packing to ensure safe handling of fragile items."
          },
          {
            "q": "Do you cover intercity transportation?",
            "a": "Yes, we provide both local and intercity shifting services."
          },
        ]
      },
    ];

    return CustomScaffoldScreen(
      title: Text(
        "FAQs",
        style: AppFonts.font14BWhiteWeight700.copyWith(fontSize: 18.sp),
      ),
      leadingIcon:
          SvgPicture.asset(AppImages.categoryIcon, width: 22.w, height: 22.h),
      notificationIcon:
          Image.asset(AppImages.notificationIcon, width: 28.w, height: 28.h),
      onLeadingTap: () => Navigator.pop(context),
      onNotificationTap: () {},
      showNotificationDot: true,
      child: Padding(
        padding: EdgeInsets.all(18.sp),
        child: Column(
          children: [
            10.verticalSpace,
            Expanded(
              child: ListView.builder(
                itemCount: faqData.length,
                itemBuilder: (context, index) {
                  final category = faqData[index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        category["category"] as String,
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: ColorsManager.orange,
                        ),
                      ),
                      ...List.generate((category["questions"] as List).length,
                          (i) {
                        final qItem = (category["questions"] as List)[i];
                        return ExpansionTile(
                          title: Text(
                            qItem["q"],
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              child: Text(
                                qItem["a"],
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: Colors.black54,
                                ),
                              ),
                            ),
                          ],
                        );
                      }),
                      const Divider(),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, RouteName.homeLayout);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: const BorderSide(color: Colors.grey),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Go to Homepage"),
                    SizedBox(width: 8),
                    Icon(Icons.arrow_forward, size: 18),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
