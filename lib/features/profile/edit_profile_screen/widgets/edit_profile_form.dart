import 'package:engzly/core/helper/functions/validators/validators.dart';
import 'package:engzly/core/routing/route_name.dart';
import 'package:engzly/core/theming/colors.dart';
import 'package:engzly/core/theming/fonts.dart';
import 'package:engzly/core/shared_widgets/custom_botton.dart';
import 'package:engzly/core/shared_widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditProfileForm extends StatelessWidget {
  const EditProfileForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomTextFormField(
              hintText: "Enter Your Full Name",
              labelText: "Full Name",
              validator: (value) => Validators.validateName(value),
              keyBordType: TextInputType.text,
              //   controller: viewModel.fullNameController,
            ),
            15.verticalSpace,
            CustomTextFormField(
              hintText: "Enter Your Current Address",
              labelText: "Current Address",
              keyBordType: TextInputType.text,
              // controller: viewModel.addressController,
              validator: (value) =>
                  Validators.validateNotEmpty(title: "Address", value: value),
            ),
            15.verticalSpace,
            CustomTextFormField(
              hintText: "Enter Your Phone Number",
              labelText: "Phone Number",
              validator: (value) => Validators.validatePhoneNumber(value),
              keyBordType: TextInputType.phone,
              //  controller: viewModel.phoneNumberController,
            ),
            15.verticalSpace,
            CustomTextFormField(
              hintText: "Enter Your Current Address",
              labelText: "Current Address",
              keyBordType: TextInputType.text,
              // controller: viewModel.addressController,
              validator: (value) =>
                  Validators.validateNotEmpty(title: "Address", value: value),
            ),
            15.verticalSpace,
            CustomTextFormField(
              hintText: "Password",
              labelText: "Password",
              keyBordType: TextInputType.text,
              //   controller: viewModel.passwordController,
              validator: (value) => Validators.validatePassword(value),
            ),
            15.verticalSpace,
            CustomButton(
              onPressed: () {
                Navigator.pushReplacementNamed(
                    context, RouteName.changePassword);
              },
              text: "Change Password",
              textStyle: AppFonts.font14BWhiteWeight700
                  .copyWith(color: ColorsManager.darkGray),
              color: Colors.white,
              height: 60.h,
              width: 310.w,
              borderRadius: 16.r,
              borderColor: ColorsManager.lightGray,
            ),
            15.verticalSpace,
            CustomButton(
              onPressed: () {
                FocusScope.of(context).unfocus();
              },
              text: "Save Changes",
              textStyle: AppFonts.font14BWhiteWeight700,
              color: ColorsManager.orange,
              height: 60.h,
              width: 310.w,
              borderRadius: 16.r,
            ),
          ],
        ),
      ),
    );
  }
}
