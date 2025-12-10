import 'package:engzly/core/routing/route_name.dart';
import 'package:engzly/core/shared_widgets/custom_botton.dart';
import 'package:engzly/core/shared_widgets/snackbar.dart';
import 'package:engzly/core/theming/colors.dart';
import 'package:engzly/core/theming/fonts.dart';
import 'package:engzly/features/auth/logic/register_cubit/cubit.dart';
import 'package:engzly/features/auth/logic/register_cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'email_confirmation_otp.dart';

class EmailConfirmation extends StatefulWidget {
  const EmailConfirmation({super.key});

  @override
  State<EmailConfirmation> createState() => _EmailConfirmationState();
}

class _EmailConfirmationState extends State<EmailConfirmation> {
  String otpCode = "";

  @override
  void initState() {
    super.initState();
    context.read<RegisterCubit>().startResendTimer();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<RegisterCubit>();

    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) => _handelStateChange(state, cubit),
      builder: (context, state) {
        return Stack(
          children: [
            Scaffold(
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    120.verticalSpace,
                    Text(
                      "Email Confirmation",
                      style: AppFonts.font36BlackWeight700.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    10.verticalSpace,
                    Text(
                      "Please check your email: \"${cubit.appProvider.email}\" to complete your registration.",
                      textAlign: TextAlign.center,
                      style: AppFonts.font20BlackWeight700.copyWith(
                        color: ColorsManager.black.withValues(alpha: 0.5),
                      ),
                    ),
                    20.verticalSpace,
                    EmailConfirmationOtp(
                      onCodeCompleted: (code) {
                        otpCode = code;
                      },
                    ),
                    20.verticalSpace,
                    CustomButton(
                      onPressed: () {
                        if (otpCode.isNotEmpty) {
                          cubit.confirmEmail(otp: otpCode);
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
                          valueListenable: cubit.isResendButtonEnabled,
                          builder: (context, isEnabled, child) {
                            return InkWell(
                              onTap: isEnabled
                                  ? () {
                                      cubit.startResendTimer();
                                    }
                                  : null,
                              child: ValueListenableBuilder<String?>(
                                valueListenable: cubit.resendButtonText,
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
            if (state is RegisterLoading)
              CircularProgressIndicator(
                color: ColorsManager.orange,
              )
          ],
        );
      },
    );
  }

  void _handelStateChange(RegisterState state, RegisterCubit cubit) {
    if (state is ConfirmEmailSuccess) {
      SnackBarManager().showSuccessSnackBar(state.message);

      Navigator.pushReplacementNamed(context, RouteName.login);
    } else if (state is ConfirmEmailError) {
      SnackBarManager().showErrorSnackBar(state.error);
    } else if (state is ResendSuccessState) {
      SnackBarManager().showSuccessSnackBar(
          'Resend OTP to your email.\n Please check your Email');

      cubit.startResendTimer();
    } else if (state is ResendErrorState) {
      SnackBarManager().showErrorSnackBar("please try again later");
    }
  }
}
