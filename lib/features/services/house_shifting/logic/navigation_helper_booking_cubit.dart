import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:engzly/features/services/house_shifting/logic/cubit.dart';
import 'package:engzly/features/services/house_shifting/logic/booking_cubit.dart';

void navigateWithBookingCubit(BuildContext context, Widget screen) {
  final houseCubit = context.read<HouseShiftingCubit>();
  final bookingCubit = context.read<HouseShiftingBookingCubit>();

  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => MultiBlocProvider(
        providers: [
          BlocProvider.value(value: houseCubit),
          BlocProvider.value(value: bookingCubit),
        ],
        child: screen,
      ),
    ),
  );
}
