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

class EditProfileForm extends StatelessWidget {
  const EditProfileForm({
    super.key,
    required this.viewModel,
  });

  final ProfileCubit viewModel;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: viewModel.formKey,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomTextFormField(
                hintText: "Enter Your Full Name",
                labelText: "Full Name",
                validator: (value) => Validators.validateName(value),
                keyBordType: TextInputType.text,
                controller: viewModel.fullNameController,
                onChanged: (_) => viewModel.checkForChanges(),
              ),
              15.verticalSpace,
              CustomTextFormField(
                hintText: "Enter Your Phone Number",
                labelText: "Phone Number",
                validator: (value) => Validators.validatePhoneNumber(value),
                keyBordType: TextInputType.phone,
                controller: viewModel.phoneNumberController,
                onChanged: (_) => viewModel.checkForChanges(),
              ),
              15.verticalSpace,
              CustomTextFormField(
                hintText: "Enter Your Current Address",
                labelText: "Current Address",
                keyBordType: TextInputType.text,
                controller: viewModel.addressController,
                validator: (value) =>
                    Validators.validateNotEmpty(title: "Address", value: value),
                onChanged: (_) => viewModel.checkForChanges(),
              ),
              15.verticalSpace,
              CustomTextFormField(
                hintText: "Enter Your Email",
                labelText: "Email Address",
                keyBordType: TextInputType.text,
                controller: viewModel.emailController,
                readOnly: true,
                validator: (value) =>
                    Validators.validateNotEmpty(title: "Email", value: value),
              ),
              5.verticalSpace,
              Padding(
                padding: EdgeInsets.only(left: 10.w),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Note: You can't change your email ",
                    style: AppFonts.font14BOrangeWeight400.copyWith(
                      color: ColorsManager.red,
                    ),
                  ),
                ),
              ),
              25.verticalSpace,
              CustomButton(
                onPressed: () {
                  Navigator.pushNamed(context, RouteName.changePassword);
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
              BlocBuilder<ProfileCubit, ProfileState>(
                builder: (context, state) {
                  final hasChanges = context.watch<ProfileCubit>().hasChanges;

                  return CustomButton(
                    onPressed: hasChanges
                        ? () {
                            FocusScope.of(context).unfocus();
                            if (viewModel.formKey.currentState!.validate()) {
                              viewModel.updateUserData();
                              viewModel.setHasChanges(false);
                            }
                          }
                        : null,
                    text: "Save Changes",
                    textStyle: AppFonts.font14BWhiteWeight700.copyWith(
                      color: hasChanges
                          ? ColorsManager.white
                          : ColorsManager.black.withValues(alpha: 0.5),
                    ),
                    color: hasChanges
                        ? ColorsManager.orange
                        : ColorsManager.lightGray,
                    height: 60.h,
                    width: 310.w,
                    borderRadius: 16.r,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
