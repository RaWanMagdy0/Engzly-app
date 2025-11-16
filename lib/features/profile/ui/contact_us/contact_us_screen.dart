import 'package:engzly/core/routing/route_name.dart';
import 'package:engzly/core/shared_widgets/custom_scaffold.dart';
import 'package:engzly/core/theming/fonts.dart';
import 'package:engzly/core/theming/images.dart';
import 'package:engzly/features/profile/ui/contact_us/widgets/support_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldScreen(
      title: Text(
        "Contact Us",
        style: AppFonts.font14BWhiteWeight700.copyWith(fontSize: 18.sp),
      ),
      leadingIcon:
          SvgPicture.asset(AppImages.categoryIcon, width: 22.w, height: 22.h),
      notificationIcon:
          Image.asset(AppImages.notificationIcon, width: 28.w, height: 28.h),
      onLeadingTap: () {},
      onNotificationTap: () {},
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            20.verticalSpace,
            Text(
              "Contact Us",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            10.verticalSpace,
            Text(
              "Please choose what types of support do you need and let us know.",
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            25.verticalSpace,
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  SupportCard(
                    icon: Icons.chat,
                    iconColor: Colors.green,
                    title: "Support Chat",
                    subtitle: "24x7 Online Support",
                  ),
                  SupportCard(
                    icon: Icons.call,
                    iconColor: Colors.orange,
                    title: "Call Center",
                    subtitle: "24x7 Customer Service",
                  ),
                  SupportCard(
                    icon: Icons.email,
                    iconColor: Colors.purple,
                    title: "Email",
                    subtitle: "admin@shifty.com",
                  ),
                  SupportCard(
                    icon: Icons.help,
                    iconColor: Colors.yellow,
                    title: "FAQ",
                    subtitle: "+50 Answers",
                    onTap: () {
                      Navigator.pushNamed(context, RouteName.questions);
                    },
                  ),
                ],
              ),
            ),
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
            10.verticalSpace,
          ],
        ),
      ),
    );
  }
}
