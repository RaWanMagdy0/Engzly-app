import 'package:engzly/core/routing/route_name.dart';
import 'package:engzly/core/shared_widgets/custom_botton.dart';
import 'package:engzly/core/shared_widgets/custom_scaffold.dart';
import 'package:engzly/core/theming/colors.dart';
import 'package:engzly/core/theming/fonts.dart';
import 'package:engzly/core/theming/images.dart';
import 'package:engzly/features/services/house_shifting/logic/booking_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';

class CleaningOrderConfirmation extends StatefulWidget {
  const CleaningOrderConfirmation({super.key});

  @override
  State<CleaningOrderConfirmation> createState() =>
      _CleaningOrderConfirmation();
}

class _CleaningOrderConfirmation extends State<CleaningOrderConfirmation> {
  // late ProfileCubit profileCubit;
  late HouseShiftingBookingCubit bookingCubit;

  @override
  void initState() {
    super.initState();
    //  profileCubit = context.read<ProfileCubit>();
    bookingCubit = context.read<HouseShiftingBookingCubit>();
    //  profileCubit.getUserData();
  }

  @override
  Widget build(BuildContext context) {
    final phoneNumber = "01048733684";

    return CustomScaffoldScreen(
      title: Text(
        "Order Confirmation",
        style: AppFonts.font14BWhiteWeight700.copyWith(fontSize: 18.sp),
      ),
      leadingIcon:
          SvgPicture.asset(AppImages.categoryIcon, width: 22.w, height: 22.h),
      notificationIcon:
          Image.asset(AppImages.notificationIcon, width: 28.w, height: 28.h),
      onLeadingTap: () {},
      onNotificationTap: () {},
      showNotificationDot: true,
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 300.h,
              width: 200.w,
              child: Lottie.asset(AppImages.cleaningSubmitCheck),
            ),
            Text(
              "Order Placed",
              style: AppFonts.font36BlackWeight700,
            ),
            10.verticalSpace,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: AppFonts.font16BlackWeight400,
                  children: [
                    const TextSpan(
                      text:
                          "Your order has been successfully placed. Our logistics team will contact you soon.\n\nFor any help, call ",
                    ),
                    WidgetSpan(
                      child: GestureDetector(
                        onTap: () => _makePhoneCall(phoneNumber),
                        child: Text(
                          phoneNumber,
                          style: AppFonts.font14BOrangeWeight400.copyWith(
                              color: ColorsManager.green,
                              decoration: TextDecoration.underline,
                              decorationColor: ColorsManager.green),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            40.verticalSpace,
            Container(
              width: double.infinity,
              height: 2.h,
              color: Colors.grey.shade200,
            ),
            20.verticalSpace,
            Text(
              "SCHEDULE",
              style: AppFonts.font16BlackWeight400.copyWith(
                fontWeight: FontWeight.w700,
                letterSpacing: 1.2,
              ),
            ),
            5.verticalSpace,
            Text(
              'EEEE, MMM dd, yyyy @ h:mm a',
              //  selectedDate != null
              //    ? DateFormat('EEEE, MMM dd, yyyy @ h:mm a')
              //      .format(selectedDate)
              //: "No date selected",
              style: AppFonts.font16BlackWeight400,
            ),
            40.verticalSpace,
            Container(
              width: double.infinity,
              height: 2.h,
              color: Colors.grey.shade200,
            ),
            20.verticalSpace,
            CustomButton(
              borderRadius: 15.r,
              height: 50.h,
              width: 300.w,
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  RouteName.homeLayout,
                  (route) => false,
                );
              },
              text: "Go to Homepage",
              color: ColorsManager.green,
              textStyle: AppFonts.font14BWhiteWeight700,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    }
  }
}
