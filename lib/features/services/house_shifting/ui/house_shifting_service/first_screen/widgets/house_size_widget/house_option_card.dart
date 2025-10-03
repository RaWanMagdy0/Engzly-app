import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HouseOptionCard extends StatelessWidget {
  final String title;
  final String iconUrl;
  final int price;

  const HouseOptionCard({
    super.key,
    required this.title,
    required this.iconUrl,
    required this.price,
  });

  String _formatTitle(String title) {
    final parts = title.split(" ");
    if (parts.length > 2) {
      final firstPart = parts.sublist(0, parts.length - 2).join(" ");
      final lastPart = parts.sublist(parts.length - 2).join(" ");
      return "$firstPart\n$lastPart";
    }
    return title;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 120.h,
          width: 110.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Image.network(iconUrl, fit: BoxFit.contain,height: 100.h,),
        ),
        Text(
          _formatTitle(title),
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}
