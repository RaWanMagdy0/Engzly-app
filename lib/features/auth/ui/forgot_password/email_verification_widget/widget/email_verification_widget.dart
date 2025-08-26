import 'package:engzly/core/theming/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'pin_code_file.dart';

class EmailVerificationWidget extends StatelessWidget {
  const EmailVerificationWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 120),
      child: Column(
        children: [
          Row(
            children: [
              Text("OTP verification", style: AppFonts.font20BlackWeight700),
              10.verticalSpace,
              Text(
                "Please check your email",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              30.verticalSpace,
              PinCodeFile(
                onCodeCompleted: (rsetCode) {
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Code Sent. Resend Code in 00:00",
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),

                  /******* 
               * 
               * ValueListenableBuilder<bool>(
                valueListenable: viewModel.isResendButtonEnabled,
                builder: (context, isEnabled, child) {
                  return InkWell(
                    onTap: isEnabled
                        ? () {
                            viewModel.resendResetCode();
                          }
                        : null,
                    child: ValueListenableBuilder<String?>(
                      valueListenable: viewModel.resendButtonText,
                      builder: (context, value, child) {
                        return Text(
                          value ?? " Resend",
                          style: isEnabled
                              ? AppFonts.font16PinkWeight400UnderlinedPink
                              : AppFonts.font16PinkWeight400UnderlinedPink,
                        );
                      },
                    ),
                  );
                },
              ),
              */
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
