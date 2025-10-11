import 'package:engzly/core/routing/route_name.dart';
import 'package:engzly/core/shared_widgets/custom_botton.dart';
import 'package:engzly/core/shared_widgets/custom_scaffold.dart';
import 'package:engzly/core/theming/colors.dart';
import 'package:engzly/core/theming/fonts.dart';
import 'package:engzly/core/theming/images.dart' show AppImages;
import 'package:engzly/features/services/cleaning/ui/cleaning/first_screen/widgets/cleaning_counter_row.dart';
import 'package:engzly/features/services/cleaning/ui/cleaning/first_screen/widgets/house_size_widget/cleaning_header_section.dart'
    show CleaningHeaderSection;
import 'package:engzly/features/services/house_shifting/logic/cubit.dart';
import 'package:engzly/features/services/house_shifting/logic/states.dart';
import 'package:engzly/features/services/house_shifting/ui/house_shifting_service/first_screen/widgets/house_size_widget/house_option_section.dart';
import 'package:engzly/features/services/house_shifting/ui/house_shifting_service/first_screen/widgets/house_size_widget/house_size_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class CleaningScreen extends StatefulWidget {
  const CleaningScreen({super.key});

  @override
  State<CleaningScreen> createState() => _CleaningScreenState();
}

class _CleaningScreenState extends State<CleaningScreen> {
  int persons = 0;

  int hours = 2;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HouseShiftingCubit>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      cubit.getHouseSize();
    });

    return CustomScaffoldScreen(
      title: Text(
        "Cleaning Service",
        style: AppFonts.font14BWhiteWeight700.copyWith(fontSize: 18.sp),
      ),
      leadingIcon:
          SvgPicture.asset(AppImages.backArrow, width: 30.w, height: 30.h),
      notificationIcon:
          Image.asset(AppImages.notificationIcon, width: 28.w, height: 28.h),
      onLeadingTap: () {
        Navigator.pop(context);
      },
      onNotificationTap: () {},
      showNotificationDot: true,
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(
              bottom: 80.h,
              top: 6.h,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const CleaningHeaderSection(),
                  BlocBuilder<HouseShiftingCubit, HouseShiftingState>(
                    buildWhen: (previous, current) =>
                        current is GetHouseSizeLoading ||
                        current is GetHouseSizeSuccess ||
                        current is GetHouseSizeError,
                    builder: (context, state) {
                      return SizedBox(
                        height: 180.h,
                        child: () {
                          if (state is GetHouseSizeLoading) {
                            return Row(
                              children: List.generate(
                                3,
                                (_) => Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 8.w),
                                  child: const HouseSizeShimmer(),
                                ),
                              ),
                            );
                          } else if (state is GetHouseSizeSuccess) {
                            final houseSizes = state.houseSizes;
                            if (houseSizes.isEmpty) {
                              return const Center(
                                  child: Text("No data available"));
                            }
                            return HouseOptionSection(options: houseSizes);
                          } else if (state is GetHouseSizeError) {
                            return Center(child: Text(state.error));
                          }
                          return const SizedBox();
                        }(),
                      );
                    },
                  ),
                  Container(
                      color: ColorsManager.lightGray,
                      width: double.infinity,
                      height: 15.h),
                  CounterRow(
                    title: 'Required Person',
                    subtitle:
                        'Regular cost is \$5/hr. Total cost will be calculated later',
                    iconPath: AppImages.workerIcon,
                    value: persons,
                    onIncrement: () => setState(() => persons++),
                    onDecrement: () => setState(() {
                      if (persons > 0) persons--;
                    }),
                  ),
                  CounterRow(
                    title: 'Working Hour',
                    subtitle: 'Cost will increase after 2 hrs of work.',
                    iconPath: AppImages.timerIcon,
                    value: hours,
                    onIncrement: () => setState(() => hours++),
                    onDecrement: () => setState(() {
                      if (hours > 0) hours--;
                    }),
                  ),
                  CounterRow(
                    title: 'Working Hour',
                    subtitle: 'Cost will increase after 2 hrs of work.',
                    iconPath: AppImages.timerIcon,
                    value: hours,
                    onIncrement: () => setState(() => hours++),
                    onDecrement: () => setState(() {
                      if (hours > 0) hours--;
                    }),
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
                Navigator.pushNamed(context, RouteName.cleaningSchedule);
                /********* 
                 *  final selection = context.read<HouseShiftingBookingCubit>();

                if (selection.selectedHouseSize == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please select a house size')),
                  );
                  return;
                }
                */
              },
              text: "Proceed",
              color: ColorsManager.green,
              textStyle: AppFonts.font14BWhiteWeight700,
            ),
          ),
        ],
      ),
    );
  }
}
