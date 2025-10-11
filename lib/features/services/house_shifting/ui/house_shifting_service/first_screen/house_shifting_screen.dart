import 'package:engzly/core/shared_widgets/custom_botton.dart';
import 'package:engzly/core/shared_widgets/custom_scaffold.dart';
import 'package:engzly/core/theming/colors.dart';
import 'package:engzly/core/theming/fonts.dart';
import 'package:engzly/core/theming/images.dart' show AppImages;
import 'package:engzly/features/services/house_shifting/logic/booking_cubit.dart';
import 'package:engzly/features/services/house_shifting/logic/cubit.dart';
import 'package:engzly/features/services/house_shifting/logic/navigation_helper_booking_cubit.dart';
import 'package:engzly/features/services/house_shifting/logic/states.dart';
import 'package:engzly/features/services/house_shifting/ui/house_shifting_service/first_screen/widgets/furniture_widgets/furniture_grid.dart';
import 'package:engzly/features/services/house_shifting/ui/house_shifting_service/first_screen/widgets/furniture_widgets/furniture_header.dart';
import 'package:engzly/features/services/house_shifting/ui/house_shifting_service/first_screen/widgets/furniture_widgets/furniture_shimmer.dart';
import 'package:engzly/features/services/house_shifting/ui/house_shifting_service/first_screen/widgets/house_size_widget/house_header_section.dart';
import 'package:engzly/features/services/house_shifting/ui/house_shifting_service/first_screen/widgets/house_size_widget/house_option_section.dart';
import 'package:engzly/features/services/house_shifting/ui/house_shifting_service/first_screen/widgets/house_size_widget/house_size_shimmer.dart';
import 'package:engzly/features/services/house_shifting/ui/house_shifting_service/first_screen/widgets/packed_boxes_card.dart';
import 'package:engzly/features/services/house_shifting/ui/house_shifting_service/second_screen/schedule_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class HouseShiftingScreen extends StatelessWidget {
  const HouseShiftingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HouseShiftingCubit>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      cubit.getHouseSize();
      cubit.getFurnitures();
    });

    return CustomScaffoldScreen(
      title: Text(
        "House Shifting Service",
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
                  const HouseHeaderSection(),
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
                  BlocBuilder<HouseShiftingCubit, HouseShiftingState>(
                    buildWhen: (previous, current) =>
                        current is GetFurnituresLoading ||
                        current is GetFurnituresSuccess ||
                        current is GetFurnituresError,
                    builder: (context, state) {
                      final count = state is GetFurnituresSuccess
                          ? state.furnitures.length
                          : 0;

                      return Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FurnitureHeader(furnituresCount: count),
                            Text(
                              "Approximate furnitures",
                              style: TextStyle(
                                  fontSize: 14.sp, color: Colors.grey.shade500),
                            ),
                            10.verticalSpace,
                            SizedBox(
                              height: 180.h,
                              child: () {
                                if (state is GetFurnituresLoading) {
                                  return GridView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 5,
                                      childAspectRatio: 0.8,
                                    ),
                                    itemCount: 10,
                                    itemBuilder: (_, __) =>
                                        const FurnitureShimmer(),
                                  );
                                } else if (state is GetFurnituresSuccess) {
                                  if (state.furnitures.isEmpty) {
                                    return const Center(
                                        child: Text("No data available"));
                                  }
                                  return FurnitureGrid(
                                      furnitures: state.furnitures);
                                } else if (state is GetFurnituresError) {
                                  return Center(child: Text(state.error));
                                }
                                return const SizedBox();
                              }(),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  Container(
                      color: ColorsManager.lightGray,
                      width: double.infinity,
                      height: 15.h),
                  const PackedBoxesCard(),
                  Container(
                      color: ColorsManager.lightGray,
                      width: double.infinity,
                      height: 15.h),
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
                final selection = context.read<HouseShiftingBookingCubit>();

                if (selection.selectedHouseSize == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please select a house size')),
                  );
                  return;
                }

                if (selection.selectedFurnitureCounts.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Please select at least one furniture')),
                  );
                  return;
                }

                navigateWithBookingCubit(context, const ScheduleScreen());
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
