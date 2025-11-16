import 'package:cached_network_image/cached_network_image.dart';
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
import 'package:flutter/foundation.dart';
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
    cubit.loadOffers();
    cubit.loadServices();
    _checkAndRequestLocationPermission();
  }

  Future<void> _checkAndRequestLocationPermission() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return;

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.deniedForever) return;
  }

  Widget buildOfferImage(String iconUrl) {
    final safeUrl = iconUrl.trim();

    if (safeUrl.isEmpty || !safeUrl.startsWith('http')) {
      return HomeShimmerWidgets.shimmerWrapper(
        Container(
          width: 260.w,
          height: 150.h,
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(15.r),
          ),
        ),
      );
    }

    return CachedNetworkImage(
      imageUrl: safeUrl,
      width: 260.w,
      height: 150.h,
      fit: BoxFit.cover,
      placeholder: (context, url) => HomeShimmerWidgets.shimmerWrapper(
        Container(
          width: 260.w,
          height: 150.h,
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(15.r),
          ),
        ),
      ),
      errorWidget: (context, url, error) => Container(
        width: 260.w,
        height: 150.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(15.r),
        ),
        child: const Icon(Icons.broken_image, color: Colors.grey, size: 48),
      ),
    );
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
        color: ColorsManager.black,
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
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  "Welcome ",
                  style:
                      AppFonts.font36BlackWeight700.copyWith(fontSize: 26.sp),
                ),
                Image.asset(
                  AppImages.hand,
                  height: 30.h,
                  width: 30.w,
                )
              ],
            ),
            Row(
              children: [
                Text(
                  "Need a helping hand today?",
                  style: AppFonts.font24greykWeight400,
                ),
              ],
            ),
            6.verticalSpace,
            ServiceRow(),
            15.verticalSpace,
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
            5.verticalSpace,
            BlocBuilder<HomeCubit, HomeState>(
              buildWhen: (previous, current) =>
                  current is HomeOffersSuccess || current is OffersLoading,
              builder: (context, state) {
                if (state is HomeOffersSuccess) {
                  final offers = state.offers;
                  if (offers.isEmpty) {
                    return HomeShimmerWidgets.buildOffersShimmer();
                  }

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      OffersTabs(
                        tabs: offers.map((e) => e.type).toList(),
                        selectedIndex: selectedTab.clamp(0, offers.length - 1),
                        onTabSelected: (index) {
                          setState(() => selectedTab = index);
                        },
                      ),
                      10.verticalSpace,
                      if (selectedTab < offers.length)
                        SizedBox(
                          height: 150.h,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: offers[selectedTab].offers.length,
                            separatorBuilder: (_, __) => SizedBox(width: 12.w),
                            itemBuilder: (context, index) {
                              final offerItem =
                                  offers[selectedTab].offers[index];
                              final iconUrl = (offerItem.icon ?? "")
                                  .trim()
                                  .replaceAll("\n", "");
                              return ClipRRect(
                                borderRadius: BorderRadius.circular(15.r),
                                child: buildOfferImage(iconUrl),
                              );
                            },
                          ),
                        )
                      else
                        const Center(child: Text("No offers available")),
                    ],
                  );
                }
                // لو لسه جاري التحميل، شيمر للـ tabs + الصور
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HomeShimmerWidgets.buildTabsShimmer(),
                    10.verticalSpace,
                    HomeShimmerWidgets.buildOffersShimmer(),
                  ],
                );
              },
            ),
            18.verticalSpace,
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Other Services",
                style: AppFonts.font14BWhiteWeight700.copyWith(
                  color: Colors.black,
                  fontSize: 18.sp,
                ),
              ),
            ),
            5.verticalSpace,
            BlocBuilder<HomeCubit, HomeState>(
              buildWhen: (previous, current) =>
                  current is HomeServicesSuccess || current is ServiceLoading,
              builder: (context, state) {
                if (state is HomeServicesSuccess) {
                  final services = state.services;
                  if (services.isEmpty) {
                    return HomeShimmerWidgets.buildServicesShimmer();
                  }

                  return SizedBox(
                    height: 110.h,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: services.length,
                      separatorBuilder: (_, __) => SizedBox(width: 8.w),
                      itemBuilder: (context, index) {
                        final service = services[index];
                        return OtherServiceCard(
                          title: service.name,
                          iconPath: service.imageUrl,
                          backgroundColor: Colors.transparent,
                          onTap: () {
                            switch (service.name.toLowerCase()) {
                              case "cleaning":
                                Navigator.pushNamed(
                                    context, RouteName.cleaning);
                                break;
                              case "vehicle":
                                Navigator.pushNamed(context, RouteName.vehicle);
                                break;
                              case "painting":
                                Navigator.pushNamed(
                                    context, RouteName.painting);
                                break;
                              default:
                                if (kDebugMode) {
                                  print("Unknown service: ${service.name}");
                                }
                            }
                          },
                        );
                      },
                    ),
                  );
                }
                return HomeShimmerWidgets.buildServicesShimmer();
              },
            ),
          ],
        ),
      ),
    );
  }
}
