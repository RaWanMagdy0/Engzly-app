import 'package:engzly/core/shared_widgets/custom_botton.dart';
import 'package:engzly/features/services/cleaning/logic/cleaning_cubit.dart';
import 'package:engzly/features/services/cleaning/ui/cleaning/order_details/cleaning_order_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:engzly/core/theming/colors.dart';

class CleaningLocationBottomSheet extends StatelessWidget {
  final String selectedAddress;
  final String selectedType;
  final Function(String) onTypeChanged;
  final VoidCallback onConfirm;

  const CleaningLocationBottomSheet({
    super.key,
    required this.selectedAddress,
    required this.selectedType,
    required this.onTypeChanged,
    required this.onConfirm,
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
              24.verticalSpace,
              CustomButton(
                text: "Proceed",
                onPressed: () {
                  if (selectedAddress.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text("Please select a location first")),
                    );
                    return;
                  }
                  onConfirm();
                  final cleaningCubit = context.read<CleaningCubit>();

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => MultiBlocProvider(
                        providers: [
                          BlocProvider.value(value: cleaningCubit),
                        ],
                        child: CleaningOrderDetails(),
                      ),
                    ),
                  );
                },
                color: ColorsManager.green,
                textColor: ColorsManager.white,
                borderRadius: 15.r,
                height: 50.h,
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
