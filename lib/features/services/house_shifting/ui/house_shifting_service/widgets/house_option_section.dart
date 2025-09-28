import 'package:flutter/material.dart';
import 'package:engzly/core/theming/colors.dart';
import 'house_option_card.dart';

class HouseOptionsSection extends StatelessWidget {
  const HouseOptionsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          HouseOptionCard(
            icon: Icons.home,
            label: "2 Bedrooms\n1 Kitchen",
            color: ColorsManager.babyOrange,
          ),
          HouseOptionCard(
            icon: Icons.house,
            label: "3 Bedrooms\n1 Kitchen",
            color: ColorsManager.babyBlue,
          ),
          HouseOptionCard(
            icon: Icons.villa,
            label: "4 Bedrooms\n1 Kitchen",
            color: ColorsManager.babyBink,
          ),
        ],
      ),
    );
  }
}
