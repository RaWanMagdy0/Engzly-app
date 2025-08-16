import 'package:flutter/material.dart';
import 'package:engzly/core/helper/spacing.dart';
import 'package:engzly/core/theming/colors.dart';

class CustomErrorScreen extends StatelessWidget {
  const CustomErrorScreen({super.key, required this.onPressed});
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, size: 64, color: ColorsManager.red),
              verticalSpacing(16),
              Text(
                'Failed to load data.',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: ColorsManager.red,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              verticalSpacing(8),
              Text(
                'Please check your connection and try again.',
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              verticalSpacing(24),
              ElevatedButton.icon(
                onPressed: onPressed,
                icon: const Icon(Icons.refresh),
                label: const Text('Retry'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorsManager.secendryColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
