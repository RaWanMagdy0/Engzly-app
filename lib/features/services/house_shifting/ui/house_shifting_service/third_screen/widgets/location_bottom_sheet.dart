import 'package:engzly/core/routing/route_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:engzly/core/theming/colors.dart';

class LocationBottomSheet extends StatelessWidget {
  final String selectedAddress;
  final String selectedType;
  final Function(String) onTypeChanged;

  const LocationBottomSheet({
    super.key,
    required this.selectedAddress,
    required this.selectedType,
    required this.onTypeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.35,
      minChildSize: 0.25,
      maxChildSize: 0.45,
      builder: (context, scrollController) {
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 8,
                offset: Offset(0, -2),
              ),
            ],
          ),
          child: ListView(
            controller: scrollController,
            children: [
              Row(
                children: [
                  const Icon(Icons.location_on, color: Colors.green),
                  8.horizontalSpace,
                  Expanded(
                    child: Text(
                      selectedAddress,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              16.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildLocationTypeIcon(
                      Icons.home, "Home", selectedType, onTypeChanged),
                  _buildLocationTypeIcon(
                      Icons.work, "Work", selectedType, onTypeChanged),
                  _buildLocationTypeIcon(Icons.add_location_alt, "Add New",
                      selectedType, onTypeChanged),
                ],
              ),
              24.verticalSpace,
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, RouteName.orderConfirmation);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorsManager.green,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: const Text("Proceed"),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLocationTypeIcon(IconData icon, String label,
      String selectedType, Function(String) onTap) {
    final isSelected = selectedType.toLowerCase() == label.toLowerCase();
    return GestureDetector(
      onTap: () => onTap(label.toLowerCase()),
      child: Column(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor:
                isSelected ? ColorsManager.green : Colors.grey.shade200,
            child: Icon(icon,
                color: isSelected ? Colors.white : Colors.black, size: 28),
          ),
          8.verticalSpace,
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: isSelected ? ColorsManager.green : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
