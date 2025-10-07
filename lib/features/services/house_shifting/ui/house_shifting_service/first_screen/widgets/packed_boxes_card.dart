import 'package:engzly/features/services/house_shifting/logic/booking_cubit.dart';
import 'package:engzly/features/services/house_shifting/logic/booking_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PackedBoxesCard extends StatelessWidget {
  const PackedBoxesCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HouseShiftingBookingCubit, HouseShiftingBookingState>(
      builder: (context, state) {
        final cubit = context.read<HouseShiftingBookingCubit>();
        final count = cubit.boxesCount;

        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 22,
                backgroundColor: Colors.orange.shade50,
                child: const Icon(Icons.inventory, color: Colors.orange),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Packed Boxes",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    SizedBox(height: 4),
                    Text("Weight below 10 Kg",
                        style: TextStyle(fontSize: 13, color: Colors.grey)),
                  ],
                ),
              ),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove_circle_outline),
                    onPressed: () {
                      if (count > 0) {
                        cubit.updateBoxesCount(count - 1);
                      }
                    },
                  ),
                  Text(
                    "$count",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add_circle_outline),
                    onPressed: () {
                      cubit.updateBoxesCount(count + 1);
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
