import 'package:engzly/core/shared_widgets/custom_botton.dart';
import 'package:engzly/core/shared_widgets/custom_scaffold.dart';
import 'package:engzly/core/theming/colors.dart';
import 'package:engzly/core/theming/fonts.dart';
import 'package:engzly/core/theming/images.dart';
import 'package:engzly/features/services/house_shifting/ui/house_shifting_service/first_screen/widgets/house_size_widget/house_size_shimmer.dart';
import 'package:engzly/features/services/painting/logic/painting_cubit.dart';
import 'package:engzly/features/services/painting/logic/painting_states.dart';
import 'package:engzly/features/services/painting/ui/painting/first_screen/widgets/painting_counter_row.dart';
import 'package:engzly/features/services/painting/ui/painting/first_screen/widgets/painting_widget/color_picker_widget.dart';
import 'package:engzly/features/services/painting/ui/painting/first_screen/widgets/painting_widget/painting_header_section.dart';
import 'package:engzly/features/services/painting/ui/painting/first_screen/widgets/painting_widget/paintinging_house_option_section.dart';
import 'package:engzly/features/services/painting/ui/painting/second_screen/painting_schedule_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class PaintingScreen extends StatefulWidget {
  const PaintingScreen({super.key});

  @override
  State<PaintingScreen> createState() => _PaintingScreenState();
}

class _PaintingScreenState extends State<PaintingScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final cubit = context.read<PaintingCubit>();
      cubit.getHouseSize();
      cubit.getColors();
    });
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<PaintingCubit>();

    return CustomScaffoldScreen(
      title: Text(
        "Cleaning Service",
      ),
      leadingIcon: SvgPicture.asset(AppImages.backArrow,
          width: 30.w, height: 30.h, color: ColorsManager.black),
      notificationIcon: Image.asset(AppImages.notificationIcon,
          width: 28.w, height: 28.h, color: ColorsManager.black),
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
                  const PaintingHeaderSection(),
                  BlocBuilder<PaintingCubit, PaintingStates>(
                    buildWhen: (previous, current) =>
                        current is GetPaintingHouseSizeLoading ||
                        current is GetPaintingHouseSizeSuccess ||
                        current is GetPaintingHouseSizeError ||
                        current is PaintingHouseSizeSelected,
                    builder: (context, state) {
                      final cubit = context.watch<PaintingCubit>();
                      final sizes = cubit.houseSizeResponse;

                      if (state is GetPaintingHouseSizeLoading) {
                        return Row(
                          children: List.generate(
                            3,
                            (_) => Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.w),
                              child: const HouseSizeShimmer(),
                            ),
                          ),
                        );
                      } else if (state is GetPaintingHouseSizeSuccess ||
                          state is PaintingHouseSizeSelected) {
                        if (sizes.isEmpty) {
                          return const Center(child: Text("No data available"));
                        }
                        return PaintingingHouseOptionSection(options: sizes);
                      } else if (state is GetPaintingHouseSizeError) {
                        return Center(child: Text(state.error));
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                  const ColorPickerWidget(),
                  20.verticalSpace,
                  Container(
                    color: ColorsManager.lightGray,
                    width: double.infinity,
                    height: 15.h,
                  ),
                  BlocBuilder<PaintingCubit, PaintingStates>(
                    builder: (context, state) {
                      return Column(
                        children: [
                          20.verticalSpace,
                          PaintingCounterRow(
                            title: 'Required Person',
                            subtitle:
                                'Regular cost is 5/hr. Total cost will be calculated later',
                            iconPath: AppImages.workerIcon,
                            value: cubit.requiredPersons,
                            onIncrement: cubit.increaserequiredPersons,
                            onDecrement: cubit.decreaserequiredPersons,
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

                if (cubit.selectedColor == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Please select a color first"),
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

                final paintingCubit = context.read<PaintingCubit>();

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => MultiBlocProvider(
                      providers: [
                        BlocProvider.value(value: paintingCubit),
                      ],
                      child: PaintingScheduleScreen(),
                    ),
                  ),
                );
              },
              text: "Proceed",
              color: ColorsManager.yellow,
              textStyle: AppFonts.font14BWhiteWeight700,
            ),
          ),
        ],
      ),
    );
  }
}
