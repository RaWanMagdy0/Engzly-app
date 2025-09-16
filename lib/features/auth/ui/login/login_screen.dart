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
      listener: (context, state) => _handelStateChange(state),
      builder: (context, state) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    100.verticalSpace,
                    Text(
                      "Let's Sign You In",
                      style: AppFonts.font36BlackWeight700,
                    ), //AppStr
                    50.verticalSpace,
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
                            ),
                          ),
                        ),
                      ],
                    ),
                    50.verticalSpace,
                    CustomButton(
                      onPressed: () {
                        FocusScope.of(context).unfocus();

                        if (_formKey.currentState!.validate()) {
                          context.read<LoginCubit>().login(
                              email: _emailController.text,
                              password: _passwordController.text,
                              rememberMe: _isRemember);
                        }
                      },
                      color: ColorsManager.orange,
                      text: state is LoginLoading ? "Loading..." : "Login",
                      textStyle: AppFonts.font14BWhiteWeight700,
                      height: 55.h,
                      width: 290.w,
                      borderRadius: 16.r,
                    ),
                    10.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Dont Have An Account ?",
                          style: AppFonts.font13BlackWeight500.copyWith(
                            fontSize: 15.sp,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, RouteName.signUp);
                          },
                          child: Text(
                            " Sign Up", //AppStrings.signUpTitle,
                            style: AppFonts.font13BlackWeight500.copyWith(
                              color: ColorsManager.orange,
                              fontSize: 15.sp,
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

  void _handelStateChange(LoginState state) {
    if (state is LoginSuccess) {
      ScaffoldMessenger.of(context)
          .showSnackBar(
            const SnackBar(
              content: Text("Login Successfully "),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 2),
            ),
          )
          .closed
          .then((_) {
        // ignore: use_build_context_synchronously
        Navigator.pushReplacementNamed(context, RouteName.homeLayout);
      });
    } else if (state is LoginError) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(state.error),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }
}
