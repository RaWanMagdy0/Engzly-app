import 'package:engzly/core/shared_widgets/custom_scaffold.dart';
import 'package:engzly/core/theming/fonts.dart';
import 'package:engzly/core/theming/images.dart';
import 'package:engzly/features/home/logic/cubit.dart';
import 'package:engzly/features/home/logic/state.dart';
import 'package:engzly/features/home/ui/widgets/home_shimmer_widget.dart';
import 'package:engzly/features/home/ui/widgets/offers_card.dart';
import 'package:engzly/features/home/ui/widgets/offers_tabs.dart';
import 'package:engzly/features/home/ui/widgets/service_row.dart';
import 'package:engzly/features/home/ui/widgets/other_services_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedTab = 0;
  late HomeCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = context.read<HomeCubit>();
    cubit.loadHomeData();
    _checkAndRequestLocationPermission();
  }

  Future<void> _checkAndRequestLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return;

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever) return;
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldScreen(
      title: Text(
        "ENGZLY ",
        style: AppFonts.font14BWhiteWeight700.copyWith(fontSize: 18.sp),
      ),
      leadingIcon:
          SvgPicture.asset(AppImages.categoryIcon, width: 22.w, height: 22.h),
      notificationIcon:
          Image.asset(AppImages.notificationIcon, width: 28.w, height: 28.h),
      onLeadingTap: () {},
      onNotificationTap: () {},
      showNotificationDot: true,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            20.verticalSpace,
            Row(
              children: [
                Text("Welcome ", style: AppFonts.font36BlackWeight700),
                Image.asset(AppImages.hand)
              ],
            ),
            Row(
              children: [
                Text("Need a helping hand today?",
                    style: AppFonts.font24greykWeight400),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    8.verticalSpace,
                    ServiceRow(),
                    12.verticalSpace,
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Offers & News",
                        style: AppFonts.font14BWhiteWeight700.copyWith(
                          color: Colors.black,
                          fontSize: 18.sp,
                        ),
                      ),
                    ),
                    8.verticalSpace,
                    BlocBuilder<HomeCubit, HomeState>(
                      builder: (context, state) {
                        if (state is HomeLoading) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              HomeShimmerWidgets.shimmerWrapper(
                                HomeShimmerWidgets.buildOffersShimmer(),
                              ),
                              16.verticalSpace,
                              HomeShimmerWidgets.shimmerWrapper(
                                HomeShimmerWidgets.buildServicesShimmer(),
                              ),
                            ],
                          );
                        } else if (state is HomeDataSuccess) {
                          final offers = state.offers;
                          final services = state.services;

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (offers.isNotEmpty) ...[
                                OffersTabs(
                                  tabs: offers.map((e) => e.type).toList(),
                                  selectedIndex: selectedTab,
                                  onTabSelected: (index) {
                                    setState(() => selectedTab = index);
                                  },
                                ),
                                8.verticalSpace,
                                SizedBox(
                                  height: 150.h,
                                  child: ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    itemCount:
                                        offers[selectedTab].offers.length,
                                    separatorBuilder: (_, __) =>
                                        SizedBox(width: 12.w),
                                    itemBuilder: (context, index) {
                                      final offer =
                                          offers[selectedTab].offers[index];
                                      return Image.network(
                                        offer.icon ?? "",
                                        fit: BoxFit.cover,
                                        errorBuilder: (_, __, ___) => SizedBox(
                                          width: 80.w,
                                          height: 80.h,
                                          child: Icon(Icons.broken_image,
                                              size: 32.sp),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ] else
                                const Text("No offers found"),
                              16.verticalSpace,
                              if (services.isNotEmpty) ...[
                                Text("Other Services",
                                    style:
                                        AppFonts.font14BWhiteWeight700.copyWith(
                                      color: Colors.black,
                                      fontSize: 18.sp,
                                    )),
                                8.verticalSpace,
                                SizedBox(
                                  height: 120.h,
                                  child: ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: services.length,
                                    separatorBuilder: (_, __) =>
                                        SizedBox(width: 10.w),
                                    itemBuilder: (context, index) {
                                      final service = services[index];
                                      return OtherServiceCard(
                                        imageUrl: service.imageUrl,
                                        title: service.name,
                                      );
                                    },
                                  ),
                                ),
                              ] else
                                const Text("No services available"),
                            ],
                          );
                        } else if (state is HomeError) {
                          return Center(
                            child: Text(state.error,
                                style: const TextStyle(color: Colors.red)),
                          );
                        }

                        return const SizedBox.shrink();
                      },
                    ),
                    30.verticalSpace,
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildServicesShimmer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 20.h,
          width: 150.w,
          color: Colors.grey[300],
          margin: EdgeInsets.only(bottom: 8.h),
        ),
        SizedBox(
          height: 120.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: 4,
            separatorBuilder: (_, __) => SizedBox(width: 12.w),
            itemBuilder: (context, index) => Container(
              width: 100.w,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
