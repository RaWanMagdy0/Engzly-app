import 'package:engzly/core/helper/functions/dialogs/app_dialogs.dart';
import 'package:engzly/core/helper/functions/validators/validators.dart';
import 'package:engzly/core/routing/route_name.dart';
import 'package:engzly/core/shared_widgets/custom_botton.dart';
import 'package:engzly/core/shared_widgets/custom_text_form_field.dart';
import 'package:engzly/core/theming/colors.dart';
import 'package:engzly/core/theming/fonts.dart';
import 'package:engzly/features/auth/logic/forget_password/reset_pass_cubit/cubit.dart';
import 'package:engzly/features/auth/logic/forget_password/reset_pass_cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordViewBodyState();
}

class _ResetPasswordViewBodyState extends State<ResetPasswordScreen> {
  late ResetPasswordCubit viewModel;
  @override
  void initState() {
    super.initState();
    viewModel = context.read<ResetPasswordCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
        listener: (context, state) => _handelStateChange(state),
        builder: (context, state) {
          return Stack(
            children: [
              Scaffold(
                body: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: viewModel.formKey,
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
                          controller: viewModel.newPasswordController,
                          keyBordType: TextInputType.text,
                          validator: (value) =>
                              Validators.validatePassword(value),
                        ),
                        20.verticalSpace,
                        CustomTextFormField(
                          hintText: "Confirm Password",
                          labelText: "Confirm Password",
                          controller: viewModel.confirmPasswordController,
                          keyBordType: TextInputType.text,
                          validator: (value) =>
                              Validators.validatePasswordConfirmation(
                            password: viewModel.newPasswordController.text,
                            confirmPassword: value,
                          ),
                        ),
                        20.verticalSpace,
                        CustomButton(
                          onPressed: () {
                            FocusScope.of(context).unfocus();
                            if (viewModel.formKey.currentState!.validate()) {
                              viewModel.resetPassword(
                                newPassword:
                                    viewModel.newPasswordController.text,
                                confirmPassword:
                                    viewModel.confirmPasswordController.text,
                              );
                            }
                          },
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
              ),
              if (state is ResetPasswordLoading)
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

  void _handelStateChange(
    ResetPasswordState state,
  ) {
    if (state is ResetPasswordSuccess) {
      AppDialogs.showSuccessDialog(
        context: context,
        message: state.message,

      );

      Future.delayed(Duration(seconds: 2), () {
        Navigator.pushReplacementNamed(context, RouteName.login);
      });
    } else if (state is ResetPasswordError) {
      AppDialogs.showErrorDialog(
        context: context,
        errorMassage: state.error,
      );
    }
  }
}
