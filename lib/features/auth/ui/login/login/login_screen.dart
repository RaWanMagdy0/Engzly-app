import 'package:engzly/core/helper/functions/dialogs/app_dialogs.dart';
import 'package:engzly/core/routing/route_name.dart';
import 'package:engzly/core/theming/colors.dart';
import 'package:engzly/core/theming/fonts.dart';
import 'package:engzly/core/shared_widgets/custom_botton.dart';
import 'package:engzly/features/auth/logic/login_cubit/google.dart/google_cubit.dart';
import 'package:engzly/features/auth/logic/login_cubit/google.dart/google_states.dart';
import 'package:engzly/features/auth/logic/login_cubit/login/cubit.dart';
import 'package:engzly/features/auth/logic/login_cubit/login/states.dart';
import 'package:engzly/features/auth/ui/login/login/widgets/login_form.dart';
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
                    50.verticalSpace,
                    Image.asset(
                      'assets/icons/unlock.png',
                      height: 100.h,
                      width: 100.w,
                      fit: BoxFit.contain,
                    ),
                    20.verticalSpace,
                    Text(
                      "Let's Sign You In",
                      style: AppFonts.font36BlackWeight700,
                    ),
                    20.verticalSpace,
                    LoginForm(
                      emailController: _emailController,
                      passwordController: _passwordController,
                    ),
                    _buildRememberAndForgetPasswordRow(),
                    10.verticalSpace,
                    _buildBottomSection(state),
                    10.verticalSpace,
                    _buildDividerWithOr(),
                    14.verticalSpace,
                    _buildGoogleLoginSection(),
                    18.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't Have An Account?",
                          style: AppFonts.font13BlackWeight500
                              .copyWith(fontSize: 16.sp),
                        ),
                        GestureDetector(
                          onTap: () =>
                              Navigator.pushNamed(context, RouteName.signUp),
                          child: Text(
                            " Sign Up",
                            style: AppFonts.font13BlackWeight500.copyWith(
                              color: ColorsManager.orange,
                              fontSize: 17.sp,
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
        );
      },
    );
  }

  Widget _buildRememberAndForgetPasswordRow() {
    return Row(
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
              style: AppFonts.font13BlackWeight500.copyWith(fontSize: 15.sp),
            ),
          ],
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, RouteName.forgetPassword);
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
    );
  }

  Widget _buildGoogleLoginSection() {
    return Column(
      children: [
        BlocListener<GoogleLoginCubit, GoogleLoginState>(
          listener: (context, state) {
            if (state is GoogleLoginSuccess) {
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
            } else if (state is GoogleLoginError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.error),
                  backgroundColor: Colors.red,
                  behavior: SnackBarBehavior.floating,
                ),
              );
            }
          },
          child: const SizedBox.shrink(),
        ),
        BlocBuilder<GoogleLoginCubit, GoogleLoginState>(
          builder: (context, state) {
            final isLoading = state is GoogleLoginLoading;

            return OutlinedButton.icon(
              onPressed: isLoading
                  ? null
                  : () => context.read<GoogleLoginCubit>().loginWithGoogle(),
              style: OutlinedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 60.w),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.r),
                ),
                side: BorderSide(color: Colors.grey[300]!),
              ),
              icon: isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Image.network(
                      'https://www.google.com/favicon.ico',
                      height: 24,
                      width: 24,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.g_mobiledata, size: 24);
                      },
                    ),
              label: Text(
                isLoading ? 'Loading..' : 'Continue with Google',
                style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: ColorsManager.black),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildDividerWithOr() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        children: [
          Expanded(child: Divider(color: Colors.grey[300])),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Text(
              'OR',
              style: TextStyle(
                  color: Colors.grey[600], fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(child: Divider(color: Colors.grey[300])),
        ],
      ),
    );
  }

  Widget _buildBottomSection(LoginState state) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 13.w),
          child: CustomButton(
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
            borderRadius: 15.r,
            height: 55.h,
          ),
        ),
      ],
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
