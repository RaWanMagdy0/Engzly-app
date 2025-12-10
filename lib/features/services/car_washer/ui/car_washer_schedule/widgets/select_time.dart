import 'package:engzly/core/theming/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectTime extends StatefulWidget {
  final Function(String)? onTimeSelected;

  const SelectTime({super.key, this.onTimeSelected});

  @override
  State<SelectTime> createState() => _SelectTime();
}

class _SelectTime extends State<SelectTime> {
  String? selectedTime;

  final List<String> timeSlots = [
    "5 pm - 6 pm",
    "6 pm - 7 pm",
    "7 pm - 8 pm",
    "8 pm - 9 pm",
    "9 pm - 10 pm",
  ];

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 5,
      runSpacing: 10,
      children: timeSlots.map((time) {
        bool isSelected = selectedTime == time;

        return GestureDetector(
          onTap: () {
            setState(() => selectedTime = time);
            widget.onTimeSelected?.call(time);
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
            decoration: BoxDecoration(
              color: isSelected
                  ? ColorsManager.green.withOpacity(0.15)
                  : ColorsManager.green.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
              border: isSelected
                  ? Border.all(color: ColorsManager.green, width: 2)
                  : null,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  time,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  "Available",
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: ColorsManager.green,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
