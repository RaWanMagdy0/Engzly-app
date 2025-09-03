import 'package:engzly/core/helper/functions/validators/validators.dart';
import 'package:engzly/core/routing/route_name.dart';
import 'package:engzly/core/theming/colors.dart';
import 'package:engzly/core/theming/fonts.dart';
import 'package:engzly/core/shared_widgets/custom_botton.dart';
import 'package:engzly/core/shared_widgets/custom_text_form_field.dart';
import 'package:engzly/features/profile/logic/cubit.dart';
import 'package:engzly/features/profile/logic/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({
    super.key,
  });

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  late ProfileCubit viewModel;
  @override
  void initState() {
    super.initState();
    viewModel = context.read<ProfileCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              100.verticalSpace,
              Text("Change Password", style: AppFonts.font36BlackWeight700),
              5.verticalSpace,
              Text(
                "Please note changing password will requiredagain login to the app..",
                textAlign: TextAlign.center,
                style: AppFonts.font16BlackWeight400.copyWith(
                  color: ColorsManager.black.withValues(alpha: 0.5),
                ),
              ),
              40.verticalSpace,
              BlocConsumer(
                  bloc: viewModel,
                  listener: (context, state) {
                    if (state is ChangePasswordSuccess) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                          state.message,
                          style: AppFonts.font14BWhiteWeight700,
                        ),
                        backgroundColor: ColorsManager.green,
                      ));
                      if (mounted) {
                        Navigator.pushReplacementNamed(
                            context, RouteName.editProfile);
                      }
                    } else if (state is ChangePasswordError) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                          state.error,
                          style: AppFonts.font14BWhiteWeight700,
                        ),
                        backgroundColor: ColorsManager.red,
                      ));
                    }
                  },
                  builder: (context, state) {
                    return Form(
                      key: viewModel.formKey,
                      child: Column(
                        children: [
                          CustomTextFormField(
                            hintText: "Current Password",
                            labelText: "Enter Your Current Password",
                            keyBordType: TextInputType.text,
                            controller: viewModel.passwordController,
                            validator: (value) =>
                                Validators.validatePassword(value),
                          ),
                          15.verticalSpace,
                          CustomTextFormField(
                            hintText: "New Password",
                            labelText: "Enter Your New Password",
                            keyBordType: TextInputType.text,
                            controller: viewModel.newPasswordController,
                            validator: (value) =>
                                Validators.validatePassword(value),
                          ),
                          15.verticalSpace,
                          CustomTextFormField(
                            hintText: "Confirm Password",
                            labelText: "Confirm Password",
                            keyBordType: TextInputType.text,
                            controller: viewModel.confirmPasswordController,
                            validator: (value) =>
                                Validators.validatePassword(value),
                          ),
                          15.verticalSpace,
                          CustomButton(
                            onPressed: () {
                              if (viewModel.formKey.currentState!.validate()) {
                                viewModel.forgetPassword(
                                  password: viewModel.passwordController.text,
                                  newPassword:
                                      viewModel.newPasswordController.text,
                                  confirmPassword:
                                      viewModel.confirmPasswordController.text,
                                );
                              }
                              FocusScope.of(context).unfocus();
                            },
                            text: "Save Password",
                            textStyle: AppFonts.font14BWhiteWeight700,
                            color: ColorsManager.orange,
                            height: 60.h,
                            width: 310.w,
                            borderRadius: 16.r,
                          ),
                        ],
                      ),
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}
