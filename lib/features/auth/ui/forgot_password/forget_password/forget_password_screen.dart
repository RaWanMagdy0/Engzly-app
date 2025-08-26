import 'package:engzly/core/helper/functions/validators/validators.dart';
import 'package:engzly/core/shared_widgets/custom_botton.dart';
import 'package:engzly/core/shared_widgets/custom_text_form_field.dart';
import 'package:engzly/core/theming/colors.dart';
import 'package:engzly/core/theming/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  /******** 
 * //  late final ForgetPasswordCubit viewModel;


  @override
  void initState() {
    super.initState();
    viewModel = context.read<ForgetPasswordCubit>();
  }
*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 120),
        child: Column(
          children: [
            Text("Forget Password", style: AppFonts.font36BlackWeight700),
            10.verticalSpace,
            Text(
              "Enter your email address to reset password.",
              textAlign: TextAlign.center,
              style: AppFonts.font16BlackWeight400.copyWith(
                fontSize: 24.sp,
                color: ColorsManager.black.withValues(alpha: 0.5),
              ),
            ),
            20.verticalSpace,
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                //key: viewModel.formKey,
                child: CustomTextFormField(
                  hintText: "Enter your email",
                  labelText: "Email Address",
                  keyBordType: TextInputType.text,
                  validator: (value) => Validators.validateEmail(value),
                  //controller: viewModel.emailController,
                ),
              ),
            ),
            25.verticalSpace,
            CustomButton(
              onPressed: () {},
              color: ColorsManager.orange,
              text: "Reset Password",
              textStyle: AppFonts.font14BWhiteWeight700,
              height: 55.h,
              width: 300.w,
              borderRadius: 16.r,
            ),
          ],
        ),
      ),
    );
  }

  /**********
  dynamic _handelStateChange(ForgotPasswordStates state) {
    if (state is ForgotPasswordSuccessState) {
      AppDialogs.showSuccessDialog(
        context: context,
        message: "OTP sent to your email.\n Please check your Email",
        whenAnimationFinished: () =>
            Navigator.pushNamed(context, PageRouteName.passwordVerification),
      );
    } else if (state is ForgotPasswordErrorState) {
      Navigator.pop(context);
      AppDialogs.showErrorDialog(
          context: context, errorMassage: state.errorMassage ?? "");
    } else if (state is ForgotPasswordLoadingState) {
      AppDialogs.showLoading(
        context: context,
      );
    }
  }
   */
}
