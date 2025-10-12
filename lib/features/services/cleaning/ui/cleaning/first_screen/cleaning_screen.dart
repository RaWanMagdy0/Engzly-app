import 'package:engzly/core/shared_widgets/custom_botton.dart';
import 'package:engzly/core/shared_widgets/custom_scaffold.dart';
import 'package:engzly/core/theming/colors.dart';
import 'package:engzly/core/theming/fonts.dart';
import 'package:engzly/core/theming/images.dart';
import 'package:engzly/features/services/cleaning/logic/cleaning_cubit.dart';
import 'package:engzly/features/services/cleaning/logic/cleaning_states.dart';
import 'package:engzly/features/services/cleaning/ui/cleaning/first_screen/widgets/cleaning_counter_row.dart';
import 'package:engzly/features/services/cleaning/ui/cleaning/first_screen/widgets/house_size_widget/cleaning_header_section.dart';
import 'package:engzly/features/services/cleaning/ui/cleaning/first_screen/widgets/house_size_widget/cleaning_house_option_section.dart';
import 'package:engzly/features/services/cleaning/ui/cleaning/second_screen/cleaning_schedule_screen.dart';
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
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CleaningCubit>().getHouseSize();
    });
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CleaningCubit>();

    return CustomScaffoldScreen(
      title: Text(
        "Cleaning Service",
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
                  const CleaningHeaderSection(),
                  BlocBuilder<CleaningCubit, CleaningStates>(
                    buildWhen: (previous, current) =>
                        current is GetHouseSizeLoading ||
                        current is GetHouseSizeSuccess ||
                        current is GetHouseSizeError ||
                        current is CleaningHouseSizeSelected,
                    builder: (context, state) {
                      final cubit = context.watch<CleaningCubit>();
                      final sizes = cubit.houseSizeResponse;

                      if (state is GetHouseSizeLoading) {
                        return Row(
                          children: List.generate(
                            3,
                            (_) => Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.w),
                              child: const HouseSizeShimmer(),
                            ),
                          ),
                        );
                      } else if (state is GetHouseSizeSuccess ||
                          state is CleaningHouseSizeSelected) {
                        if (sizes.isEmpty) {
                          return const Center(child: Text("No data available"));
                        }
                        return CleaningHouseOptionSection(options: sizes);
                      } else if (state is GetHouseSizeError) {
                        return Center(child: Text(state.error));
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                  Container(
                    color: ColorsManager.lightGray,
                    width: double.infinity,
                    height: 15.h,
                  ),
                  BlocBuilder<CleaningCubit, CleaningStates>(
                    builder: (context, state) {
                      return Column(
                        children: [
                          CounterRow(
                            title: 'Required Person',
                            subtitle:
                                'Regular cost is \$5/hr. Total cost will be calculated later',
                            iconPath: AppImages.workerIcon,
                            value: cubit.requiredPersons,
                            onIncrement: cubit.increasePersons,
                            onDecrement: cubit.decreasePersons,
                          ),
                          30.verticalSpace,
                          CounterRow(
                            title: 'Working Hour',
                            subtitle: 'Cost will increase after 2 hrs of work.',
                            iconPath: AppImages.timerIcon,
                            value: cubit.workingHours,
                            onIncrement: cubit.increaseWorkingHours,
                            onDecrement: cubit.decreaseWorkingHours,
                          ),
                        ],
                      );
                    },
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
                if (cubit.selectedHouseSize == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Please select a house size first"),
                    ),
                  );
                  return;
                }

                if (cubit.requiredPersons <= 0) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Please select at least one worker"),
                    ),
                  );
                  return;
                }

                if (cubit.workingHours < 1) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Please select valid working hours"),
                    ),
                  );
                  return;
                }
                final cleaningCubit = context.read<CleaningCubit>();

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => MultiBlocProvider(
                      providers: [
                        BlocProvider.value(value: cleaningCubit),
                      ],
                      child: CleaningScheduleScreen(),
                    ),
                  ),
                );
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
