import 'package:engzly/features/services/cleaning/logic/cleaning_cubit.dart';
import 'package:engzly/features/services/cleaning/ui/ui/order_details/widgets/cleaning_order_item.dart';
import 'package:engzly/features/services/cleaning/ui/ui/order_details/widgets/cleaning_order_summry.dart';
import 'package:flutter/material.dart';

class CleaningOrderItemsList extends StatelessWidget {
  final CleaningCubit cubit;
  final double personCost;
  final double serviceCharge;

  const CleaningOrderItemsList({
    super.key,
    required this.cubit,
    required this.personCost,
    required this.serviceCharge,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CleaningOrderItem(
          icon: '🏠',
          title: cubit.selectedHouseSize?.name ?? "No house selected",
          subtitle: '1 Kitchen Included',
          price: cubit.selectedHouseSizePrice != null
              ? "${cubit.selectedHouseSizePrice}/hr"
              : "—",
          backgroundColor: const Color(0xFFFFE0B2),
        ),
        CleaningOrderItem(
          icon: '👷',
          title: '${cubit.requiredPersons} Cleaner',
          subtitle: '+\$5 for additional cleaner',
          price: "${personCost.toStringAsFixed(0)}/hr",
          backgroundColor: const Color(0xFFE3F2FD),
        ),
        CleaningOrderSummry(
          label: 'Service Charge',
          value: '\$${serviceCharge.toStringAsFixed(0)}',
        ),
      ],
    );
  }
}