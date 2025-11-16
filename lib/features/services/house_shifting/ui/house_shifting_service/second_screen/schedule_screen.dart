import 'package:engzly/core/shared_widgets/custom_botton.dart';
import 'package:engzly/core/shared_widgets/custom_scaffold.dart';
import 'package:engzly/core/theming/colors.dart';
import 'package:engzly/core/theming/fonts.dart';
import 'package:engzly/core/theming/images.dart';
import 'package:engzly/features/services/house_shifting/logic/booking_cubit.dart';
import 'package:engzly/features/services/house_shifting/logic/booking_states.dart';
import 'package:engzly/features/services/house_shifting/logic/cubit.dart';
import 'package:engzly/features/services/house_shifting/logic/navigation_helper_booking_cubit.dart';
import 'package:engzly/features/services/house_shifting/logic/states.dart';
import 'package:engzly/features/services/house_shifting/ui/house_shifting_service/second_screen/widgets/table_calender_widget.dart';
import 'package:engzly/features/services/house_shifting/ui/house_shifting_service/second_screen/widgets/truck_card.dart';
import 'package:engzly/features/services/house_shifting/ui/house_shifting_service/third_screen/choose_location.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HouseShiftingCubit>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      cubit.getVehicles();
    });

    return CustomScaffoldScreen(
      title: Text(
        "Schedule Shifting",
      ),
      leadingIcon: SvgPicture.asset(AppImages.backArrow,
          width: 30.w, height: 30.h, color: ColorsManager.black),
      notificationIcon: Image.asset(AppImages.notificationIcon,
          width: 28.w, height: 28.h, color: ColorsManager.black),
      onLeadingTap: () {
        Navigator.pop(context);
      },
      onNotificationTap: () {},
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TableCalenderWidget(
              onDateSelected: (selectedDate) {
                context
                    .read<HouseShiftingBookingCubit>()
                    .selectDate(selectedDate);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text("Choose Suitable Truck",
                  style: AppFonts.font20BlackWeight700),
            ),
          ),
          BlocBuilder<HouseShiftingCubit, HouseShiftingState>(
            buildWhen: (prev, curr) =>
                curr is GetVehiclesLoading ||
                curr is GetVehiclesSuccess ||
                curr is GetVehiclesError,
            builder: (context, state) {
              if (state is GetVehiclesLoading) {
                return SizedBox(
                  height: 160.h,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    itemCount: 3,
                    separatorBuilder: (_, __) => 12.horizontalSpace,
                    itemBuilder: (_, __) => Container(
                      width: 120.w,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                    ),
                  ),
                );
              } else if (state is GetVehiclesSuccess) {
                final vehicles = state.vehicles;
                return SizedBox(
                  height: 160.h,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    itemCount: vehicles.length,
                    separatorBuilder: (_, __) => 12.horizontalSpace,
                    itemBuilder: (context, index) {
                      final vehicle = vehicles[index];
                      return GestureDetector(
                        onTap: () {
                          context
                              .read<HouseShiftingBookingCubit>()
                              .selectVehicle(
                                  vehicle.id, vehicle.name, vehicle.price);
                        },
                        child: BlocBuilder<HouseShiftingBookingCubit,
                            HouseShiftingBookingState>(
                          builder: (context, bookingState) {
                            final isSelected = context
                                    .read<HouseShiftingBookingCubit>()
                                    .selectedVehicleId ==
                                vehicle.id;
                            return TruckCard(
                              imageUrl: vehicle.icon,
                              title: vehicle.name,
                              subtitle: "~ ${vehicle.capacity} Ton",
                              isSelected: isSelected,
                            );
                          },
                        ),
                      );
                    },
                  ),
                );
              } else if (state is GetVehiclesError) {
                return Center(child: Text(state.error));
              }
              return const SizedBox();
            },
          ),
          const Spacer(),
          CustomButton(
            borderRadius: 15.r,
            height: 50.h,
            width: 300.w,
            onPressed: () {
              final bookingCubit = context.read<HouseShiftingBookingCubit>();

              if (bookingCubit.selectedDate == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Please select the day first')),
                );
                return;
              }

              if (bookingCubit.selectedVehicleId == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Please select a truck')),
                );
                return;
              }

              navigateWithBookingCubit(context, const HouseChooseLocationScreen());
            },
            text: "Process",
            color: ColorsManager.orange,
            textStyle: AppFonts.font14BWhiteWeight700,
          ),
          20.verticalSpace
        ],
      ),
    );
  }
}
