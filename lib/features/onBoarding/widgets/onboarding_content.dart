import 'package:engzly/core/theming/fonts.dart';
import 'package:flutter/material.dart';

class OnboardingContent extends StatelessWidget {
  const OnboardingContent({
    super.key,
    required this.mainText,
    required this.caption,
  });

  final String mainText;
  final String caption;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(mainText, style: AppFonts.font36BlackWeight700),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            caption,
            style: AppFonts.font16BlackWeight400.copyWith(
              color: Colors.black.withValues(alpha: 0.5),
            ),
            textAlign: TextAlign.center,
            softWrap: true,
          ),
        ),
      ],
    );
  }
}
