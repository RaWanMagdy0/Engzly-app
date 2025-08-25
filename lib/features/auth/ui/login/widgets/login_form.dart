import 'package:engzly/core/helper/functions/validators/validators.dart';
import 'package:engzly/core/shared_widgets/custom_text_form_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginForm extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const LoginForm({
    super.key,
    required this.emailController,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextFormField(
          hintText: "Enter your email",
          labelText: "Email Address",
          controller: emailController,
          keyBordType: TextInputType.text,
          validator: (value) => Validators.validateEmail(value),
        ),
        20.verticalSpace,
        CustomTextFormField(
          hintText: "Enter your password",
          labelText: "Password",
          controller: passwordController,
          keyBordType: TextInputType.text,
          validator: (value) => Validators.validatePassword(value),
        ),
      ],
    );
  }
}
