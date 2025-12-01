import 'package:engzly/features/services/cleaning/data/models/response/house_size_model.dart/house_size_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'cleaning_house_option_card.dart';

class CleaningHouseOptionSection extends StatelessWidget {
  final List<HouseSizeModel> options;

  const CleaningHouseOptionSection({
    super.key,
    required this.options,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: options.map((item) {
            return Padding(
              padding: EdgeInsets.only(right: 9.0.w),
              child: CleaningHouseOptionCard(
                houseSize: item,
                houseSizePrice: item.price,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
