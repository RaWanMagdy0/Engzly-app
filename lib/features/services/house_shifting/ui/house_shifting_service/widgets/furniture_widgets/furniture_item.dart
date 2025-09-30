import 'package:engzly/features/services/house_shifting/data/models/furniture_model.dart';
import 'package:flutter/material.dart' ;
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FurnitureItem extends StatelessWidget {
  final FurnitureModel furniture;

  const FurnitureItem({super.key, required this.furniture});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          radius: 30.r,
          backgroundColor: Colors.orange.withValues(alpha: 0.2),
          child: Image.network(
            furniture.icon,
            height: 50.h,
            width: 50.w,
            errorBuilder: (context, error, stackTrace) {
              return const Icon(Icons.broken_image, size: 28, color: Colors.grey);
            },
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return const Center(
                child: CircularProgressIndicator(strokeWidth: 2),
              );
            },
          ),
        ),
        Text(
          furniture.name,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
