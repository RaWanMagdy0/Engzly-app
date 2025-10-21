import 'package:engzly/core/helper/functions/dialogs/app_dialogs.dart';
import 'package:engzly/core/routing/route_name.dart';
import 'package:engzly/core/theming/colors.dart';
import 'package:engzly/core/theming/fonts.dart';
import 'package:engzly/core/shared_widgets/custom_botton.dart';
import 'package:engzly/features/auth/logic/login_cubit/cubit.dart';
import 'package:engzly/features/auth/logic/login_cubit/states.dart';
import 'package:engzly/features/auth/ui/login/widgets/login_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isRemember = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) => _handleStateChange(state),
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: true,
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    80.verticalSpace,
                    Text(
                      "Let's Sign You In",
                      style: AppFonts.font36BlackWeight700,
                    ),
                    20.verticalSpace,
                    LoginForm(
                      emailController: _emailController,
                      passwordController: _passwordController,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              value: _isRemember,
                              activeColor: ColorsManager.orange,
                              onChanged: (value) {
                                setState(() {
                                  _isRemember = value ?? false;
                                });
                              },
                            ),
                            Text(
                              "Remember Me",
                              style: AppFonts.font13BlackWeight500.copyWith(
                                fontSize: 15.sp,
                              ),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                                context, RouteName.forgetPassword);
                          },
                          child: Text(
                            "Forget Password?",
                            style: AppFonts.font13BlackWeight500.copyWith(
                              fontSize: 15.sp,
                              color: ColorsManager.orange,
                              decoration: TextDecoration.underline,
                              decorationColor: ColorsManager.orange,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          bottomNavigationBar: Padding(
            padding: EdgeInsets.only(
              left: 16.w,
              right: 16.w,
              bottom: MediaQuery.of(context).viewInsets.bottom + 30.h,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomButton(
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    if (_formKey.currentState!.validate()) {
                      context.read<LoginCubit>().login(
                            email: _emailController.text,
                            password: _passwordController.text,
                            rememberMe: _isRemember,
                          );
                    }
                  },
                  color: ColorsManager.orange,
                  text: state is LoginLoading ? "Loading..." : "Login",
                  textStyle: AppFonts.font14BWhiteWeight700,
                  height: 55.h,
                  width: double.infinity,
                  borderRadius: 16.r,
                ),
                10.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't Have An Account?",
                      style: AppFonts.font13BlackWeight500
                          .copyWith(fontSize: 15.sp),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, RouteName.signUp);
                      },
                      child: Text(
                        " Sign Up",
                        style: AppFonts.font13BlackWeight500.copyWith(
                          color: ColorsManager.orange,
                          fontSize: 15.sp,
                          decoration: TextDecoration.underline,
                          decorationColor: ColorsManager.orange,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _handleStateChange(LoginState state) {
    if (state is LoginSuccess) {
      AppDialogs.showSuccessDialog(
        context: context,
        message: "Login Successfully",
      );
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            RouteName.homeLayout,
            (route) => false,
          );
        }
      });
    } else if (state is LoginError) {
      AppDialogs.showErrorDialog(
        context: context,
        errorMassage: state.error,
      );
    }
  }
}
