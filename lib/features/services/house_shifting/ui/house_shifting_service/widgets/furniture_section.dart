import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FurnitureSection extends StatelessWidget {
  const FurnitureSection({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> furnitures = [
      {"icon": Icons.bed, "title": "Bed", "color": Colors.blue},
      {"icon": Icons.chair, "title": "Sofa", "color": Colors.orange},
      {"icon": Icons.chair_alt, "title": "Chair", "color": Colors.lightBlue},
      {"icon": Icons.door_sliding, "title": "Almira", "color": Colors.brown},
      {"icon": Icons.ac_unit, "title": "AC", "color": Colors.redAccent},
      {"icon": Icons.kitchen, "title": "Fridge", "color": Colors.teal},
      {"icon": Icons.microwave, "title": "Oven", "color": Colors.deepOrange},
      {"icon": Icons.tv, "title": "TV", "color": Colors.green},
      {"icon": Icons.tv, "title": "Wardrobe", "color": Colors.purple},
      {"icon": Icons.add, "title": "Add", "color": Colors.amber},
    ];

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Furnitures",
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  )),
              TextButton.icon(
                style: ButtonStyle(
                  backgroundColor:
                      WidgetStateProperty.all<Color>(Colors.grey.shade100),
                  padding: WidgetStateProperty.all(
                    EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                  ),
                ),
                onPressed: () {},
                icon: const Icon(Icons.cancel,
                    size: 18, color: Colors.black54),
                label: Text(
                  "2 Item",
                  style: TextStyle(
                    color: Colors.orange,
                    fontWeight: FontWeight.w600,
                    fontSize: 14.sp,
                  ),
                ),
              ),
            ],
          ),
          Text(
            "Approximate furnitures",
            style: TextStyle(fontSize: 14.sp, color: Colors.grey.shade500),
          ),
          20.verticalSpace,
          Wrap(
            spacing: 10.w,
            runSpacing: 15.h,
            children: furnitures.map((furniture) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    radius: 30.r,
                    backgroundColor: furniture["color"].withOpacity(0.2),
                    child: Icon(
                      furniture["icon"],
                      color: furniture["color"],
                      size: 28.sp,
                    ),
                  ),
                  8.verticalSpace,
                  Text(
                    furniture["title"],
                    style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500),
                  ),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
