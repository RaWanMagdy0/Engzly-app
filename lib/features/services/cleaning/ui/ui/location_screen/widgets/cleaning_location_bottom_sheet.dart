import 'package:engzly/features/services/cleaning/data/models/response/location_response/location_model.dart';
import 'package:engzly/features/services/cleaning/logic/cleaning_cubit.dart';
import 'package:engzly/features/services/cleaning/ui/ui/order_details/cleaning_order_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:engzly/core/theming/colors.dart';

class CleaningLocationBottomSheet extends StatelessWidget {
  final String selectedAddress;
  final String selectedType;
  final Function(String) onTypeChanged;
  final Function(String) onSelectAddress;
  final CleaningCubit cleaningCubit;
  final List<LocationModel> locations;

  const CleaningLocationBottomSheet({
    super.key,
    required this.selectedAddress,
    required this.selectedType,
    required this.onTypeChanged,
    required this.onSelectAddress,
    required this.cleaningCubit,
    required this.locations,
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
                  Icon(Icons.location_on, color: ColorsManager.green),
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
              16.verticalSpace,
              ElevatedButton(
                onPressed: () {
                  cleaningCubit.selectLocation(selectedAddress);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => MultiBlocProvider(
                        providers: [
                          BlocProvider.value(value: cleaningCubit),
                        ],
                        child: const CleaningOrderDetails(),
                      ),
                    ),
                  );
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
