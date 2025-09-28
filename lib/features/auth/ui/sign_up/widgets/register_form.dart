import 'package:engzly/core/helper/functions/validators/validators.dart';
import 'package:engzly/core/theming/colors.dart';
import 'package:engzly/core/theming/fonts.dart';
import 'package:engzly/core/shared_widgets/custom_botton.dart';
import 'package:engzly/core/shared_widgets/custom_text_form_field.dart';
import 'package:engzly/features/auth/logic/register_cubit/cubit.dart';
import 'package:engzly/features/auth/ui/sign_up/widgets/terms_conditions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterFormFields extends StatefulWidget {
  final RegisterCubit viewModel;

  const RegisterFormFields({super.key, required this.viewModel});

  @override
  State<RegisterFormFields> createState() => _RegisterFormFieldsState();
}

class _RegisterFormFieldsState extends State<RegisterFormFields> {
  final _termsKey = GlobalKey<TermsAndConditionsCheckboxState>();

  @override
  Widget build(BuildContext context) {
    final viewModel = widget.viewModel;

    return Form(
      key: viewModel.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomTextFormField(
            hintText: "Enter Your Full Name",
            labelText: "Full Name",
            validator: (value) => Validators.validateName(value),
            keyBordType: TextInputType.text,
            controller: viewModel.fullNameController,
          ),
          15.verticalSpace,
          CustomTextFormField(
            hintText: "Enter Your Email",
            labelText: "Email Address",
            validator: (value) => Validators.validateEmail(value),
            keyBordType: TextInputType.text,
            controller: viewModel.emailController,
          ),
          15.verticalSpace,
          CustomTextFormField(
            hintText: "Enter Your Current Address",
            labelText: "Current Address",
            keyBordType: TextInputType.text,
            controller: viewModel.addressController,
            validator: (value) =>
                Validators.validateNotEmpty(title: "Address", value: value),
          ),
          15.verticalSpace,
          CustomTextFormField(
            hintText: "Enter Your Phone Number",
            labelText: "Phone Number",
            validator: (value) => Validators.validatePhoneNumber(value),
            keyBordType: TextInputType.phone,
            controller: viewModel.phoneNumberController,
          ),
          15.verticalSpace,
          CustomTextFormField(
            hintText: "Password",
            labelText: "Password",
            keyBordType: TextInputType.text,
            controller: viewModel.passwordController,
            validator: (value) => Validators.validatePassword(value),
          ),
          15.verticalSpace,
          CustomTextFormField(
            hintText: "Confirm Password",
            labelText: "Confirm Password",
            keyBordType: TextInputType.text,
            validator: (value) => Validators.validatePasswordConfirmation(
              password: viewModel.passwordController.text,
              confirmPassword: viewModel.confirmPasswordController.text,
            ),
            controller: viewModel.confirmPasswordController,
          ),
          10.verticalSpace,
          TermsAndConditionsCheckbox(key: _termsKey, onChanged: (value) {}),
          15.verticalSpace,
          CustomButton(
            onPressed: () {
              FocusScope.of(context).unfocus();

              final isFormValid = viewModel.formKey.currentState!.validate();
              final isAgreed = _termsKey.currentState?.validate() ?? false;
              if (isFormValid && isAgreed) {
                viewModel.register(
                  fullName: viewModel.fullNameController.text,
                  address: viewModel.addressController.text,
                  password: viewModel.passwordController.text,
                  confirmPassword: viewModel.confirmPasswordController.text,
                  phoneNumber: viewModel.phoneNumberController.text,
                  email: viewModel.emailController.text,
                );
              }
            },
            text: "Continue",
            textStyle: AppFonts.font14BWhiteWeight700,
            color: ColorsManager.orange,
            height: 50.h,
            width: 290.w,
            borderRadius: 16.r,
          ),
        ],
      ),
    );
  }
}
