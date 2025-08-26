import 'package:engzly/core/theming/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class EmailConfirmationOtp extends StatelessWidget {
  final Function(String) onCodeCompleted;

  const EmailConfirmationOtp({super.key, required this.onCodeCompleted});

  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      appContext: (context),
      length: 6,
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(10),
        fieldHeight: 60.h,
        fieldWidth: 47.w,
        activeColor: ColorsManager.lightGray,
        inactiveColor: ColorsManager.lightGray,
        selectedFillColor: ColorsManager.white,
        activeFillColor: ColorsManager.white,
        selectedColor: ColorsManager.orange,
      ),
      //  animationDuration: const Duration(milliseconds: 200),
      keyboardType: TextInputType.phone,
      enabled: true,
      onCompleted: (value) {
        if (value.length == 6) {
          onCodeCompleted(value);
        }
      },
    );
  }
}
