import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:engzly/core/helper/spacing.dart';
import 'package:engzly/core/theming/colors.dart';
import 'package:engzly/core/theming/styles.dart';

class CustomTextFormField extends StatelessWidget {
  final String hintText;
  final String? labelText;
  final bool obscureText;
  final bool readOnly;
  final bool autofocus;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final int? maxLines;
  final int? maxLength;
  final String? errorText;
  final String? helperText;
  final Color? fillColor;
  final bool isCollapsed;
  final FloatingLabelBehavior floatingLabelBehavior;
  final EdgeInsetsGeometry? contentPadding;
  final TextStyle? hintStyle;
  final TextStyle? labelStyle;
  final TextStyle? floatingLabelStyle;
  final TextStyle? errorStyle;
  final TextStyle? helperStyle;
  final Color enabledBorderColor;
  final Color focusedBorderColor;
  final Color errorBorderColor;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final AutovalidateMode? autovalidateMode;
  const CustomTextFormField({
    super.key,
    this.hintText = '',
    this.labelText,
    this.obscureText = false,
    this.readOnly = false,
    this.autofocus = false,
    this.prefixIcon,
    this.suffixIcon,
    this.keyboardType,
    this.maxLines = 1,
    this.maxLength,
    this.errorText,
    this.helperText,
    this.fillColor,
    this.isCollapsed = false,
    this.floatingLabelBehavior = FloatingLabelBehavior.auto,
    this.contentPadding,
    this.hintStyle,
    this.labelStyle,
    this.floatingLabelStyle,
    this.errorStyle,
    this.helperStyle,

    this.enabledBorderColor = ColorsManager.lightGray,
    this.focusedBorderColor = ColorsManager.secendryColor,
    this.errorBorderColor = ColorsManager.red,
    this.controller,
    this.focusNode,
    this.validator,
    this.onChanged,
    this.autovalidateMode,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (labelText != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Text(
              labelText!,
              style: labelStyle ?? TextStylesManager.font18DarkGrayMedium,
            ),
          ),
        verticalSpacing(4),
        TextFormField(
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: ColorsManager.black),

          autofocus: autofocus,
          maxLines: obscureText ? 1 : maxLines,
          maxLength: maxLength,
          readOnly: readOnly,
          focusNode: focusNode,
          controller: controller,
          onChanged: onChanged,
          obscureText: obscureText,
          keyboardType: keyboardType,
          validator: validator,
          autovalidateMode: autovalidateMode,
          cursorColor: focusedBorderColor,
          decoration: InputDecoration(
            isCollapsed: isCollapsed,
            filled: true,

            fillColor: fillColor ?? ColorsManager.white,
            hintText: hintText,
            hintStyle:
                hintStyle ??
                Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: Color(0xff808191)),
            contentPadding:
                contentPadding ??
                const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            floatingLabelBehavior: floatingLabelBehavior,
            floatingLabelStyle: floatingLabelStyle,
            errorText: errorText,
            errorStyle: errorStyle,
            helperText: helperText,
            helperStyle: helperStyle,
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            suffixIconConstraints: const BoxConstraints(maxHeight: 48),
            enabledBorder: _buildBorder(enabledBorderColor),
            focusedBorder: _buildBorder(focusedBorderColor),
            errorBorder: _buildBorder(errorBorderColor),
            focusedErrorBorder: _buildBorder(errorBorderColor),
            border: _buildBorder(enabledBorderColor),
          ),
        ),
      ],
    );
  }

  OutlineInputBorder _buildBorder(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.r),
      borderSide: BorderSide(color: color, width: readOnly ? 1.0 : 1.2),
    );
  }
}
