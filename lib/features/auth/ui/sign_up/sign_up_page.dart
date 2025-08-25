import 'package:engzly/core/theming/colors.dart';
import 'package:engzly/core/theming/fonts.dart';
import 'package:engzly/core/shared_widgets/custom_botton.dart';
import 'package:engzly/core/shared_widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool _isAgreed = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Register",
          style: AppFonts.font20BlackWeight700.copyWith(fontSize: 18.sp),
        ),
        forceMaterialTransparency: true,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Text("Getting Started", style: AppFonts.font36BlackWeight700),

            15.verticalSpace,
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: CustomTextFormField(
                            hintText: "Enter Your Full Name",
                            labelText: "Full Name",
                            // validator: (value) => Validators.validateName(value),
                              keyBordType: TextInputType.text,
                            //   controller: _firstNameController,
                          ),
                        ),
                      ],
                    ),
                    CustomTextFormField(
                      hintText: "Enter Your Email",
                      labelText: "Email Address",
                      //   validator: (value) => Validators.validateEmail(value),
                      keyBordType: TextInputType.text,
                      //    controller: _emailController,
                    ),
                    CustomTextFormField(
                      hintText: "Enter Your Current Address",
                      labelText: "Current Address",

                      // validator: (value) => Validators.validatePhoneNumber(value),
                       keyBordType: TextInputType.phone,
                      //  textInputAction: TextInputAction.done,
                      //   controller: _phoneNumberController,
                    ),

                    Row(
                      children: [
                        Expanded(
                          child: CustomTextFormField(
                            hintText: " Zip Code",
                            labelText: " Zip Code",

                             keyBordType: TextInputType.text,
                            //  controller: _passwordController,
                          ),
                        ),
                        Expanded(
                          child: CustomTextFormField(
                            hintText: "State",
                            labelText: "State",
                             keyBordType: TextInputType.text,

                            //   controller: _confirmPasswordController,
                          ),
                        ),
                      ],
                    ),
                    CustomTextFormField(
                      hintText: " Password",
                      labelText: " Password",
                      //  isPassword: true,
                       keyBordType: TextInputType.text,
                      //  controller: _passwordController,
                    ),
                    CustomTextFormField(
                      hintText: "Confirm Passwprd",
                      labelText: "Confirm Password",
                       keyBordType: TextInputType.text,

                      //   controller: _confirmPasswordController,
                    ),
                  ],
                ),
              ),
            ),
            Row(
              children: [
                Checkbox(
                  value: _isAgreed,
                  activeColor: ColorsManager.orange,
                  onChanged: (value) {
                    setState(() {
                      _isAgreed = value ?? false;
                    });
                  },
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "By creating an account, you agree to our ",
                      style: AppFonts.font12BlackWeight400,
                    ),
                    InkWell(
                      onTap: () {},
                      child: Text(
                        "Terms and Conditions",
                        style: AppFonts.font12BlackWeight400.copyWith(
                          decoration: TextDecoration.underline,
                          color: ColorsManager.orange,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),

            CustomButton(
              onPressed: () {},
              text: "Containue",
              textStyle: AppFonts.font14BWhiteWeight700,
              color: ColorsManager.orange,
              height: 50.h,
              width: 290.w,
              borderRadius: 16.r,
            ),
            5.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already Have An Account?",
                  style: AppFonts.font16BlackWeight400,
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  borderRadius: BorderRadius.circular(15.r),
                  child: RichText(
                    text: TextSpan(
                      text: " Login",
                      style: AppFonts.font14BOrangeWeight400,
                    ),
                  ),
                ),
              ],
            ),
            25.verticalSpace,
          ],
        ),
      ),
    );
  }
}
