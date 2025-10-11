import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:engzly/features/services/house_shifting/data/models/house_size_model.dart';
import 'house_option_card.dart';

class HouseOptionSection extends StatelessWidget {
  final List<HouseSizeModel> options;

  const HouseOptionSection({super.key, required this.options});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: options.map((item) {
          return Padding(
            padding: EdgeInsets.only(right: 9.0.w),
            child: HouseOptionCard(
              houseSize: item,
              houseSizePrice: item.price ,
            ),
          );
        }).toList(),
      ),
    );
  }
}
