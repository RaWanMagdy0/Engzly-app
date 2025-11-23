import 'package:engzly/features/services/house_shifting/logic/booking_cubit.dart';
import 'package:engzly/core/theming/colors.dart';
import 'package:engzly/features/services/house_shifting/ui/house_shifting_service/order_details/order_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HouseShiftingLocationBottomSheet extends StatelessWidget {
  final String selectedAddress;
  final String selectedType;
  final Function(String) onTypeChanged;
  final Function(String) onSelectAddress;
  final HouseShiftingBookingCubit cubit;

  const HouseShiftingLocationBottomSheet({
    super.key,
    required this.selectedAddress,
    required this.selectedType,
    required this.onTypeChanged,
    required this.onSelectAddress,
    required this.cubit,
  });

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.33,
      minChildSize: 0.33,
      maxChildSize: 0.33,
      builder: (context, scrollController) {
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
          ),
          child: ListView(
            controller: scrollController,
            children: [
              Row(
                children: [
                  const Icon(Icons.location_on, color: ColorsManager.orange),
                  8.horizontalSpace,
                  Expanded(
                    child: Text(
                      selectedAddress,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14.sp,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              20.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildType(Icons.home, "Home"),
                  _buildType(Icons.work, "Work"),
                  _buildType(Icons.add_location_alt, "Add New"),
                ],
              ),
              20.verticalSpace,
              ElevatedButton(
                onPressed: () {
                  cubit.selectLocation(selectedAddress);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => BlocProvider.value(
                        value: cubit,
                        child: const OrderDetails(),
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorsManager.orange,
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

  Widget _buildType(IconData icon, String label) {
    final bool isSelected = selectedType.toLowerCase() == label.toLowerCase();

    return GestureDetector(
      onTap: () => onTypeChanged(label.toLowerCase()),
      child: Column(
        children: [
          CircleAvatar(
            radius: 26,
            backgroundColor:
                isSelected ? ColorsManager.orange : Colors.grey.shade300,
            child: Icon(icon,
                size: 26, color: isSelected ? Colors.white : Colors.black),
          ),
          6.verticalSpace,
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: isSelected ? ColorsManager.orange : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
