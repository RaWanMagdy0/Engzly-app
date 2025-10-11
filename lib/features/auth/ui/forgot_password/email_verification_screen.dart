import 'package:engzly/core/helper/functions/dialogs/app_dialogs.dart';
import 'package:engzly/core/routing/route_name.dart';
import 'package:engzly/core/shared_widgets/custom_botton.dart';
import 'package:engzly/core/theming/colors.dart';
import 'package:engzly/core/theming/fonts.dart';
import 'package:engzly/core/theming/images.dart';
import 'package:engzly/features/auth/logic/forget_password/verify_email/cubit.dart';
import 'package:engzly/features/auth/logic/forget_password/verify_email/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'widgets/pin_code_file.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({
    super.key,
  });

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  late VerifyEmailCubit viewModel;
  String otpCode = "";

  @override
  void initState() {
    super.initState();
    context.read<VerifyEmailCubit>().startResendTimer();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<VerifyEmailCubit>();

    return BlocConsumer<VerifyEmailCubit, VerifyEmailState>(
        listener: (context, state) => _handelStateChange(state, viewModel),
        builder: (context, state) {
          return Stack(
            children: [
              Scaffold(
                body: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
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
                          "Please check your email:\n \"${viewModel.appProvider.email}\" to reset Your password.",
                          textAlign: TextAlign.center,
                          style: AppFonts.font12BlackWeight400.copyWith(
                            color: ColorsManager.black.withValues(alpha: 0.5),
                            fontSize: 21.sp,
                          ),
                        ),
                        20.verticalSpace,
                        PinCodeFile(
                          onCodeCompleted: (code) {
                            otpCode = code;
                          },
                        ),
                        20.verticalSpace,
                        CustomButton(
                          onPressed: () {
                            if (otpCode.isNotEmpty) {
                              viewModel.verifyEmail(verficationCode: otpCode);
                            }
                          },
                          text: "Confirm",
                          textStyle: AppFonts.font14BWhiteWeight700,
                          color: ColorsManager.orange,
                          height: 50.h,
                          width: 290.w,
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
                            ValueListenableBuilder<bool>(
                              valueListenable: viewModel.isResendButtonEnabled,
                              builder: (context, isEnabled, child) {
                                return InkWell(
                                  onTap: isEnabled
                                      ? () {
                                          viewModel.startResendTimer();
                                        }
                                      : null,
                                  child: ValueListenableBuilder<String?>(
                                    valueListenable: viewModel.resendButtonText,
                                    builder: (context, value, child) {
                                      return Text(
                                        value ?? "Resend",
                                        style: AppFonts.font14BOrangeWeight400
                                            .copyWith(
                                                color:
                                                    isEnabled
                                                        ? ColorsManager.orange
                                                        : ColorsManager.orange,
                                                decoration:
                                                    TextDecoration.underline,
                                                decorationColor:
                                                    ColorsManager.orange),
                                      );
                                    },
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              if (state is VerifyEmailLoading)
                Positioned.fill(
                  child: Container(
                    color: Colors.black.withValues(alpha: 0.3),
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: Colors.orange,
                      ),
                    ),
                  ),
                ),
            ],
          );
        });
  }

  void _handelStateChange(VerifyEmailState state, VerifyEmailCubit cubit) {
    if (state is VerifyEmailSuccess) {
      AppDialogs.showSuccessDialog(
        context: context,
        message: state.message,
      );

      Future.delayed(Duration(seconds: 2), () {
        Navigator.pushReplacementNamed(context, RouteName.resetPassword);
      });
    } else if (state is VerifyEmailError) {
      AppDialogs.showErrorDialog(
        context: context,
        errorMassage: state.error,
      );
    } else if (state is ResendSuccessState) {
      AppDialogs.showSuccessDialog(

        

        context: context,
        message: "Resend OTP to your email.\n Please check your Email",
      );
    } else if (state is ResendErrorState) {
      AppDialogs.showErrorDialog(
        context: context,
        errorMassage: "Please Try Again",
      );
    }
  }
}
