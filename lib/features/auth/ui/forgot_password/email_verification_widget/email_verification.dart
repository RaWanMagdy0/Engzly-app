import 'package:engzly/features/auth/ui/forgot_password/email_verification_widget/widget/email_verification_widget.dart'
    show EmailVerificationWidget;
import 'package:engzly/features/auth/ui/forgot_password/reset_password_widget/reset_password_widget.dart';
import 'package:flutter/material.dart';

class EmailVerification extends StatefulWidget {
  const EmailVerification({super.key});
  @override
  State<EmailVerification> createState() => _EmailVerificationState();
}

class _EmailVerificationState extends State<EmailVerification> {
  List<Widget> page = [];

  // var viewModel = getIt.get<ForgetPasswordCubit>();
  @override
  void initState() {
    super.initState();
    //  viewModel = context.read<ForgetPasswordCubit>();
    page = [
      EmailVerificationWidget(
        // viewModel: viewModel,
      ),
      ResetPasswordViewBody(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
     //   controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: page,
      ),
    );
  }

  /********** 
  dynamic _handleStateChange(ForgotPasswordStates state) {
    if (state is VerifyEmailCodeSuccessState) {
      Navigator.pop(context);
      viewModel.pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.bounceInOut,
      );
      viewModel.startResendTimer();
    } else if (state is VerifyEmailCodeLoadingState) {
      AppDialogs.showLoading(context: context);
    } else if (state is VerifyEmailCodeErrorState) {
      Navigator.pop(context);
      AppDialogs.showErrorDialog(
        context: context,
        errorMassage: state.errorMassage ?? "An unknown error occurred",
      );
    } else if (state is ResendLoadingState) {
      AppDialogs.showLoading(context: context);
    } else if (state is ResendSuccessState) {
      Navigator.pop(context);
      AppDialogs.showSuccessDialog(
        context: context,
        message: "Resend OTP to your email.\n Please check your Email",
      );
      viewModel.startResendTimer();
    } else if (state is ResendErrorState) {
      Navigator.pop(context);
      AppDialogs.showErrorDialog(
        context: context,
        errorMassage: state.errorMassage ?? "An unknown error occurred",
      );
    }
  }
  */
}
