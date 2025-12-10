import 'package:engzly/core/di/di.dart';
import 'package:engzly/core/routing/route_name.dart';
import 'package:engzly/features/services/house_shifting/logic/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:engzly/features/home/logic/cubit.dart';
import 'package:engzly/features/home/logic/state.dart';
import 'package:engzly/features/home/data/models/service/service_response_model.dart';
import 'package:engzly/features/home/ui/widgets/service_card.dart';
import 'package:engzly/features/services/house_shifting/logic/booking_cubit.dart';
import 'package:engzly/features/services/house_shifting/ui/house_shifting_service/first_screen/house_shifting_screen.dart';

import 'package:engzly/core/helper/functions/dialogs/app_dialogs.dart';
import 'package:engzly/core/theming/colors.dart';

class ServiceRow extends StatefulWidget {
  const ServiceRow({super.key});

  @override
  State<ServiceRow> createState() => _ServiceRowState();
}

class _ServiceRowState extends State<ServiceRow> {
  late HomeCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = context.read<HomeCubit>();
    cubit.loadServices();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        ServiceResponseModel houseShiftingService =
            ServiceResponseModel(id: 0, name: "House\nShifting", imageUrl: '');

        if (cubit.serviceResponse.isNotEmpty) {
          final found = cubit.serviceResponse.firstWhere(
            (service) => service.name.toLowerCase() == "house shifting",
            orElse: () => houseShiftingService,
          );

          houseShiftingService = ServiceResponseModel(
            id: found.id,
            name: found.name.replaceAll(" ", "\n"),
            imageUrl: '',
          );
        }

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: ServiceCard(
                icon: Icons.home,
                backgroundColor: ColorsManager.babyBink,
                iconBackgroundColor: ColorsManager.ovalBinkColor,
                iconColor: Colors.red,
                title: houseShiftingService.name,
                onTab: () {
                  if (houseShiftingService.id != 0) {
                    final bookingCubit =
                        context.read<HouseShiftingBookingCubit>();
                    bookingCubit.selectService(houseShiftingService.id);

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MultiBlocProvider(
                            providers: [
                              BlocProvider(
                                create: (context) =>
                                    getIt<HouseShiftingCubit>(),
                              ),
                              BlocProvider(
                                create: (context) =>
                                    getIt<HouseShiftingBookingCubit>(),
                              ),
                            ],
                            child: const HouseShiftingScreen(),
                          ),
                        ));
                    print(houseShiftingService.id);
                  }
                },
              ),
            ),
            12.horizontalSpace,
            Expanded(
              child: ServiceCard(
                icon: Icons.local_car_wash,
                backgroundColor: const Color.fromARGB(255, 201, 234, 203),
                iconBackgroundColor: const Color.fromARGB(255, 227, 246, 233),
                iconColor: Colors.green,
                title: "Car Wash\nService",
                onTab: () {
                  Navigator.pushNamed(context, RouteName.carWasher);
                },
              ),
            ),
            12.horizontalSpace,
            Expanded(
              child: ServiceCard(
                icon: Icons.business,
                backgroundColor: ColorsManager.babyBlue,
                iconBackgroundColor: ColorsManager.ovalBlueColor,
                iconColor: Colors.blue,
                title: "Commercial\nShifting",
                onTab: () {
                  AppDialogs.showErrorDialog(
                    context: context,
                    errorMassage: "This service is coming soon",
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
