import 'package:flutter/material.dart';
import 'house_option_card.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class HouseOptionSection extends StatelessWidget {
  final List<HouseOptionCard> options;

  const HouseOptionSection({super.key, required this.options});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: options
            .map(
              (option) => Padding(
                padding: EdgeInsets.only(right: 9.0.w),
                child: option,
              ),
            )
            .toList(),
      ),
    );
  }
}
