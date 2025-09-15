import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:engzly/core/shared_widgets/custom_botton.dart';
import 'package:engzly/core/theming/colors.dart';

class LocationBottomSheet extends StatefulWidget {
  final String address;
  final Function(String type) onProceed;

  const LocationBottomSheet({
    super.key,
    required this.address,
    required this.onProceed,
  });

  @override
  State<LocationBottomSheet> createState() => _LocationTypeBottomSheetState();
}

class _LocationTypeBottomSheetState extends State<LocationBottomSheet> {
  String selectedType = "home";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              const Icon(Icons.location_on, color: Colors.green),
              8.horizontalSpace,
              Expanded(
                child: Text(
                  widget.address,
                  style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close),
              ),
            ],
          ),
          16.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildLocationTypeIcon(Icons.home, "Home"),
              _buildLocationTypeIcon(Icons.work, "Work"),
              _buildLocationTypeIcon(Icons.add_location_alt, "Other"),
            ],
          ),
          24.verticalSpace,
          CustomButton(
            backgroundColor: ColorsManager.orange,
            onPressed: () {
              widget.onProceed(selectedType);
              Navigator.pop(context);
            },
            child: const Text(
              "Proceed",
              style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationTypeIcon(IconData icon, String label) {
    final isSelected = selectedType.toLowerCase() == label.toLowerCase();
    return GestureDetector(
      onTap: () => setState(() => selectedType = label.toLowerCase()),
      child: Column(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: isSelected ? ColorsManager.green : Colors.grey.shade200,
            child: Icon(icon, color: isSelected ? Colors.white : Colors.black, size: 28),
          ),
          8.verticalSpace,
          Text(label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: isSelected ? ColorsManager.green : Colors.black,
              )),
        ],
      ),
    );
  }
}
