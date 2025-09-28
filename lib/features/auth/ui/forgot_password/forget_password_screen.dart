import 'package:engzly/core/helper/functions/dialogs/app_dialogs.dart';
import 'package:engzly/core/helper/functions/validators/validators.dart';
import 'package:engzly/core/routing/route_name.dart';
import 'package:engzly/core/shared_widgets/custom_botton.dart';
import 'package:engzly/core/shared_widgets/custom_text_form_field.dart';
import 'package:engzly/core/theming/colors.dart';
import 'package:engzly/core/theming/fonts.dart';
import 'package:engzly/features/auth/logic/forget_password/forget_pass_cubit/cubit.dart';
import 'package:engzly/features/auth/logic/forget_password/forget_pass_cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPasswordScreen> {
  late ForgetPasswordCubit viewModel;
  @override
  void initState() {
    super.initState();
    viewModel = context.read<ForgetPasswordCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ForgetPasswordCubit, ForgetPasswordState>(
        listener: (context, state) => _handelStateChange(state),
        builder: (context, state) {
          return Stack(
            children: [
              Scaffold(
                body: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        100.verticalSpace,
                        Text("Forget Password",
                            style: AppFonts.font36BlackWeight700),
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
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            key: viewModel.formKey,
                            child: CustomTextFormField(
                              hintText: "Enter your email",
                              labelText: "Email Address",
                              keyBordType: TextInputType.text,
                              validator: (value) =>
                                  Validators.validateEmail(value),
                              controller: viewModel.emailController,
                            ),
                          ),
                        ),
                        15.verticalSpace,
                        CustomButton(
                          onPressed: () {
                            FocusScope.of(context).unfocus();
                            if (viewModel.formKey.currentState!.validate()) {
                              viewModel.forgetPassword(
                                email: viewModel.emailController.text,
                              );
                            }
                          },
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
                ),
              ),
              if (state is ForgetPasswordLoading)
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
    ForgetPasswordState state,
  ) {
    if (state is ForgetPasswordSuccess) {
      AppDialogs.showSuccessDialog(
        context: context,
        message: state.message,
      );

      Future.delayed(Duration(seconds: 2), () {
        Navigator.pushReplacementNamed(context, RouteName.emailVerification);
      });
    } else if (state is ForgetPasswordError) {
      AppDialogs.showErrorDialog(
        context: context,
        errorMassage: state.error,
      );
    }
  }
}
