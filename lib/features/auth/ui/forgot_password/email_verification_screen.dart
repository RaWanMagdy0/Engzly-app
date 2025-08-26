import 'package:engzly/core/routing/route_name.dart';
import 'package:engzly/core/shared_widgets/custom_botton.dart';
import 'package:engzly/core/theming/colors.dart';
import 'package:engzly/core/theming/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'widgets/pin_code_file.dart';

class EmailVerificationScreen extends StatelessWidget {
  const EmailVerificationScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            120.verticalSpace,
            Text(
              "Email Verification",
              style: AppFonts.font36BlackWeight700.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
            10.verticalSpace,
            Text(
              "Please check your email: \"${"cubit.appProvider.email"}\" to reset password.",
              textAlign: TextAlign.center,
              style: AppFonts.font12BlackWeight400.copyWith(
                color: ColorsManager.black.withValues(alpha: 0.5),
                fontSize: 24.sp,
              ),
            ),
            20.verticalSpace,
            PinCodeFile(
              onCodeCompleted: (code) {},
            ),
            20.verticalSpace,
            CustomButton(
              onPressed: () {
                Navigator.pushReplacementNamed(
                    context, RouteName.resetPassword);
              },
              text: "Confirm",
              textStyle: AppFonts.font14BWhiteWeight700,
              color: ColorsManager.orange,
              height: 50.h,
              width: 300.w,
              borderRadius: 16.r,
            ),
            10.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Code Sent. Resend Code in ",
                  style: AppFonts.font14BOrangeWeight400.copyWith(
                    color: ColorsManager.black,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
