import 'package:engzly/core/routing/route_name.dart';
import 'package:engzly/core/shared_widgets/custom_scaffold.dart';
import 'package:engzly/core/theming/colors.dart';
import 'package:engzly/core/theming/fonts.dart';
import 'package:engzly/core/theming/images.dart';
import 'package:engzly/features/home/logic/cubit.dart';
import 'package:engzly/features/home/logic/state.dart';
import 'package:engzly/features/home/ui/widgets/home_shimmer_widget.dart';
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
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            AppImages.logo,
            width: 22.w,
            height: 22.h,
            color: ColorsManager.black,
          ),
          10.horizontalSpace,
          Text(
            "ENGZLY ",
            style: AppFonts.font14BWhiteWeight700.copyWith(
              fontSize: 18.sp,
              color: ColorsManager.black,
            ),
          ),
        ],
      ),
      leadingIcon: SvgPicture.asset(
        AppImages.categoryIcon,
        width: 22.w,
        height: 22.h,
        // ignore: deprecated_member_use
        color: ColorsManager.white,
      ),
      notificationIcon: Image.asset(
        AppImages.notificationIcon,
        width: 28.w,
        height: 28.h,
        color: ColorsManager.black,
      ),
      onLeadingTap: () {},
      onNotificationTap: () {
        Navigator.pushNamed(context, RouteName.notification);
      },
      showNotificationDot: true,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    15.verticalSpace,
                    Row(
                      children: [
                        Text("Welcome ",
                            style: AppFonts.font36BlackWeight700
                                .copyWith(fontSize: 26.sp)),
                        Image.asset(
                          AppImages.hand,
                          height: 30.h,
                          width: 30.w,
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Text("Need a helping hand today?",
                            style: AppFonts.font24greykWeight400),
                      ],
                    ),
                    8.verticalSpace,
                    ServiceRow(),
                    20.verticalSpace,
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
                              HomeShimmerWidgets.buildTabsShimmer(),
                              8.verticalSpace,
                              HomeShimmerWidgets.buildOffersShimmer(),
                              16.verticalSpace,
                              HomeShimmerWidgets.buildServicesShimmer(),
                            ],
                          );
                        } else if (state is HomeDataSuccess) {
                          final offers = state.offers;

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
                                      return ClipRRect(
                                        borderRadius: BorderRadiusGeometry.all(
                                            Radius.circular(15.r)),
                                        child: Image.network(
                                          offer.icon ?? "",
                                          width: 260.w,
                                          height: 150.h,
                                          fit: BoxFit.cover,
                                          errorBuilder: (_, __, ___) =>
                                              Icon(Icons.broken_image),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ] else
                                const Text("No offers found"),
                              20.verticalSpace,
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
                                  itemCount:
                                      OtherServiceCard.staticServices.length,
                                  separatorBuilder: (_, __) =>
                                      SizedBox(width: 25.w),
                                  itemBuilder: (context, index) {
                                    final service =
                                        OtherServiceCard.staticServices[index];
                                    return OtherServiceCard(
                                      title: service['title'],
                                      iconPath: service['iconPath'],
                                      backgroundColor:
                                          service['backgroundColor'],
                                      onTap: () {
                                        switch (service['title']) {
                                          case 'Cleaning':
                                            Navigator.pushNamed(
                                                context, RouteName.cleaning);
                                          case 'Vehicle':
                                            Navigator.pushNamed(
                                                context, RouteName.vehicle);

                                          case 'Painting':
                                            Navigator.pushNamed(
                                                context, RouteName.painting);
                                            break;
                                        }
                                      },
                                    );
                                  },
                                ),
                              ),
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
}
