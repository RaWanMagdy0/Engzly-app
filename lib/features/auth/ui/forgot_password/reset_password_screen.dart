import 'package:engzly/core/helper/functions/validators/validators.dart';
import 'package:engzly/core/shared_widgets/custom_botton.dart';
import 'package:engzly/core/shared_widgets/custom_text_form_field.dart';
import 'package:engzly/core/theming/colors.dart';
import 'package:engzly/core/theming/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordViewBodyState();
}

class _ResetPasswordViewBodyState extends State<ResetPasswordScreen> {
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
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              120.verticalSpace,
              Text(
                "Set New Password",
                style: AppFonts.font36BlackWeight700.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              10.verticalSpace,
              Text(
                "Create strong and secured new password.",
                textAlign: TextAlign.center,
                style: AppFonts.font12BlackWeight400.copyWith(
                  color: ColorsManager.black.withValues(alpha: 0.5),
                  fontSize: 24.sp,
                ),
              ),
              20.verticalSpace,
              CustomTextFormField(
                hintText: " Enter New Password",
                labelText: " Password",
                controller: newPasswordController,
                keyBordType: TextInputType.text,
                validator: (value) => Validators.validatePassword(value),
              ),
              20.verticalSpace,
              CustomTextFormField(
                hintText: "Confirm Password",
                labelText: "Confirm Password",
                controller: confirmPasswordController,
                keyBordType: TextInputType.text,
                validator: (value) => Validators.validatePasswordConfirmation(
                  password: newPasswordController.text,
                  confirmPassword: value,
                ),
              ),
              20.verticalSpace,
              CustomButton(
                onPressed: () {},
                color: ColorsManager.orange,
                text: "Confirm Password",
                textStyle: AppFonts.font14BWhiteWeight700,
                height: 55.h,
                width: 320.w,
                borderRadius: 16.r,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
