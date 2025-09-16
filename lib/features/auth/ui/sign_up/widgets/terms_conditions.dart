import 'package:flutter/material.dart';
import 'package:engzly/core/theming/colors.dart';
import 'package:engzly/core/theming/fonts.dart';

class TermsAndConditionsCheckbox extends StatefulWidget {
  final Function(bool) onChanged;

  const TermsAndConditionsCheckbox({super.key, required this.onChanged});

  @override
  State<TermsAndConditionsCheckbox> createState() =>
      TermsAndConditionsCheckboxState();
}

class TermsAndConditionsCheckboxState
    extends State<TermsAndConditionsCheckbox> {
  bool _isAgreed = false;
  String? _errorMessage;

  void _toggleAgreement(bool? value) {
    setState(() {
      _isAgreed = value ?? false;
      _errorMessage = null;
    });
    widget.onChanged(_isAgreed);
  }

  bool validate() {
    if (!_isAgreed) {
      setState(() {
        _errorMessage = "You must agree to continue";
      });
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Checkbox(
              value: _isAgreed,
              activeColor: ColorsManager.orange,
              onChanged: _toggleAgreement,
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
        if (_errorMessage != null)
          Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: Text(
              _errorMessage!,
              style: const TextStyle(color: Colors.red, fontSize: 12),
            ),
          ),
      ],
    );
  }
}
