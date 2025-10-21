import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:engzly/features/services/painting/logic/painting_cubit.dart';
import 'package:engzly/features/services/painting/logic/painting_states.dart';
import 'color_picker_shimmer.dart';

class ColorPickerWidget extends StatelessWidget {
  const ColorPickerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaintingCubit, PaintingStates>(
      buildWhen: (previous, current) =>
          current is GetColorsLoading ||
          current is GetColorsSuccess ||
          current is GetColorsError ||
          current is PaintingColorSelected,
      builder: (context, state) {
        final cubit = context.read<PaintingCubit>();
        final colors = cubit.colorsResponse;
        final selectedColor = cubit.selectedColor;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Choose Color",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 12),

            if (state is GetColorsLoading) ...[
              const ColorPickerShimmer(),
            ] else if (state is GetColorsError) ...[
              const Text(
                "Failed to load colors",
                style: TextStyle(color: Colors.redAccent),
              ),
            ] else if (colors.isEmpty) ...[
              const Text("No colors available"),
            ] else ...[
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: colors.map((color) {
                    final isSelected = selectedColor?.colorIcon == color.colorIcon;
                    return GestureDetector(
                      onTap: () => cubit.selectColor(color),
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 6),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color:
                                isSelected ? Colors.black : Colors.transparent,
                            width: 2,
                          ),
                        ),
                        child: CircleAvatar(
                          radius: 24,
                          backgroundColor: Colors.transparent,
                          backgroundImage: NetworkImage(color.colorIcon),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ],
        );
      },
    );
  }
}
