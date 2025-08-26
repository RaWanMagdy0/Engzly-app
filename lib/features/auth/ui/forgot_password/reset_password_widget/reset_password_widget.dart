import 'package:engzly/core/helper/functions/validators/validators.dart';
import 'package:engzly/core/shared_widgets/custom_botton.dart';
import 'package:engzly/core/shared_widgets/custom_text_form_field.dart';
import 'package:engzly/core/theming/colors.dart';
import 'package:engzly/core/theming/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResetPasswordViewBody extends StatefulWidget {
  const ResetPasswordViewBody({super.key});

  @override
  State<ResetPasswordViewBody> createState() => _ResetPasswordViewBodyState();
}

class _ResetPasswordViewBodyState extends State<ResetPasswordViewBody> {
  var confirmPasswordController = TextEditingController();
  var newPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    confirmPasswordController.dispose();
    newPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15.sp),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            30.verticalSpace,

            Text(
              "resetPasswordScreenTitle",
              style: AppFonts.font12BlackWeight400.copyWith(fontSize: 18),
            ),
            10.verticalSpace,

            Text(
              "resetPasswordScreenDescription",
              textAlign: TextAlign.center,
              style: AppFonts.font12BlackWeight400,
            ),
            20.verticalSpace,

            CustomTextFormField(
              hintText: " Enter New Password",
              labelText: "New Password",
              controller: newPasswordController,
              keyBordType: TextInputType.text,
              validator: (value) => Validators.validatePassword(value),
            ),
            20.verticalSpace,
            CustomTextFormField(
              hintText: "Enter Confirm Password",
              labelText: "Confirm Password",
              controller: confirmPasswordController,
              keyBordType: TextInputType.text,
              validator:
                  (value) => Validators.validatePasswordConfirmation(
                    password: newPasswordController.text,
                    confirmPassword: value,
                  ),
            ),
            40.verticalSpace,
            CustomButton(
              onPressed: () {},
              color: ColorsManager.white,
              text: "Confirm ",
              textStyle: AppFonts.font16BlackWeight400,
              borderColor: ColorsManager.orange,
            ),
          ],
        ),
      ),
    );
  }

  /****** 
  void _handelStateChange(ForgotPasswordStates state) {
    if (state is ResetPasswordSuccessState) {
      Navigator.pop(context);
      AppDialogs.showSuccessDialog(
        context: context,
        message: "Password Changed Successfully",
        whenAnimationFinished: () {
          Navigator.pushNamedAndRemoveUntil(
            context,
            PageRouteName.logIn,
                (route) => false,
          );
        },
      );
    } else if (state is ResetPasswordErrorState) {
      Navigator.pop(context);
      AppDialogs.showErrorDialog(
        context: context,
        errorMassage: state.errorMassage ?? "",
      );
    } else if (state is ResetPasswordLoadingState) {
      AppDialogs.showLoading(context: context);
    }
  }
  */
}
