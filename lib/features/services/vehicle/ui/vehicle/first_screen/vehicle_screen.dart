import 'package:engzly/core/shared_widgets/custom_botton.dart';
import 'package:engzly/core/shared_widgets/custom_scaffold.dart';
import 'package:engzly/core/theming/colors.dart';
import 'package:engzly/core/theming/fonts.dart';
import 'package:engzly/core/theming/images.dart';
import 'package:engzly/features/services/vehicle/logic/vehicle_cubit.dart';
import 'package:engzly/features/services/vehicle/logic/vehicle_states.dart';
import 'package:engzly/features/services/vehicle/ui/vehicle/first_screen/widgets/house_size_widget/vehicle_header_section.dart';
import 'package:engzly/features/services/vehicle/ui/vehicle/first_screen/widgets/house_size_widget/vehicle_house_option_section.dart';
import 'package:engzly/features/services/vehicle/ui/vehicle/first_screen/widgets/house_size_widget/vehicle_shimmer.dart';
import 'package:engzly/features/services/vehicle/ui/vehicle/second_screen/vehicle_schedule_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class VehicleScreen extends StatefulWidget {
  const VehicleScreen({super.key});

  @override
  State<VehicleScreen> createState() => _VehicleScreenState();
}

class _VehicleScreenState extends State<VehicleScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<VehicleCubit>().getVehicles();
    });
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<VehicleCubit>();

    return CustomScaffoldScreen(
      title: Text(
        "Vehicles Service",
        style: AppFonts.font14BWhiteWeight700.copyWith(fontSize: 18.sp),
      ),
      leadingIcon:
          SvgPicture.asset(AppImages.backArrow, width: 30.w, height: 30.h),
      notificationIcon:
          Image.asset(AppImages.notificationIcon, width: 28.w, height: 28.h),
      onLeadingTap: () => Navigator.pop(context),
      onNotificationTap: () {},
      showNotificationDot: true,
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 80.h, top: 6.h),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  5.verticalSpace,
                  const VehicleHeaderSection(),
                  BlocBuilder<VehicleCubit, VehicleStates>(
                    buildWhen: (previous, current) =>
                        current is GetVehicleVehiclesLoading ||
                        current is GetVehicleVehiclesSuccess ||
                        current is GetVehicleVehiclesError ||
                        current is VehicleSelected,
                    builder: (context, state) {
                      final cubit = context.watch<VehicleCubit>();
                      final vehicle = cubit.vehicleResponse;

                      if (state is GetVehicleVehiclesLoading) {
                        return Row(
                          children: List.generate(
                            3,
                            (_) => Expanded(
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.w),
                                child: const VehicleShimmer(),
                              ),
                            ),
                          ),
                        );
                      } else if (state is GetVehicleVehiclesSuccess ||
                          state is VehicleSelected) {
                        if (vehicle.isEmpty) {
                          return const Center(child: Text("No data available"));
                        }
                        return VehicleHouseOptionSection(options: vehicle);
                      } else if (state is GetVehicleVehiclesError) {
                        return Center(child: Text(state.error));
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                  20.verticalSpace,
                  Container(
                    color: ColorsManager.lightGray,
                    width: double.infinity,
                    height: 15.h,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 30.w,
            right: 30.w,
            bottom: 16.h,
            child: CustomButton(
              borderRadius: 20.r,
              height: 50.h,
              onPressed: () {
                if (cubit.selectedVehcile == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Please select a vehicle first"),
                    ),
                  );
                  return;
                }

                final vehicleCubit = context.read<VehicleCubit>();

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => MultiBlocProvider(
                      providers: [
                        BlocProvider.value(value: vehicleCubit),
                      ],
                      child: VehicleScheduleScreen(),
                    ),
                  ),
                );
              },
              text: "Proceed",
              color: ColorsManager.orange,
              textStyle: AppFonts.font14BWhiteWeight700,
            ),
          ),
        ],
      ),
    );
  }
}
