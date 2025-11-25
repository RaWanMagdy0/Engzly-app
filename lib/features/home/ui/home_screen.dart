import 'package:cached_network_image/cached_network_image.dart';
import 'package:engzly/core/di/di.dart';
import 'package:engzly/core/routing/route_name.dart';
import 'package:engzly/core/shared_widgets/custom_scaffold.dart';
import 'package:engzly/core/theming/colors.dart';
import 'package:engzly/core/theming/fonts.dart';
import 'package:engzly/core/theming/images.dart';
import 'package:engzly/features/home/logic/cubit.dart';
import 'package:engzly/features/home/logic/state.dart';
import 'package:engzly/features/home/ui/widgets/home_shimmer_widget.dart';
import 'package:engzly/features/home/ui/widgets/offer_card.dart';
import 'package:engzly/features/home/ui/widgets/offers_tabs.dart';
import 'package:engzly/features/home/ui/widgets/service_row.dart';
import 'package:engzly/features/home/ui/widgets/other_services_card.dart';
import 'package:engzly/features/services/cleaning/logic/cleaning_cubit.dart';
import 'package:engzly/features/services/cleaning/ui/cleaning/first_screen/cleaning_screen.dart';
import 'package:engzly/features/services/house_shifting/logic/booking_cubit.dart';
import 'package:engzly/features/services/house_shifting/logic/cubit.dart';
import 'package:engzly/features/services/house_shifting/ui/house_shifting_service/first_screen/house_shifting_screen.dart';
import 'package:engzly/features/services/painting/logic/painting_cubit.dart';
import 'package:engzly/features/services/painting/ui/painting/first_screen/painting_screen.dart';
import 'package:engzly/features/services/vehicle/logic/vehicle_cubit.dart';
import 'package:engzly/features/services/vehicle/ui/vehicle/first_screen/vehicle_screen.dart';
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
                          height: 140.h,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: offers[selectedTab].offers.length,
                            separatorBuilder: (_, __) => SizedBox(width: 12.w),
                            itemBuilder: (context, index) {
                              final offerItem =
                                  offers[selectedTab].offers[index];

                              return OfferCard(
                                offer: offerItem,
                                onTap: () {
                                  final name =
                                      offerItem.serviceName.toLowerCase();

                                  switch (name) {
                                    case "vehicle":
                                      final cubit =
                                          context.read<VehicleCubit>();
                                      cubit.selectService(offerItem.id);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => BlocProvider.value(
                                            value: cubit,
                                            child: const VehicleScreen(),
                                          ),
                                        ),
                                      );
                                      break;

                                    case "cleaning":
                                      final cubit =
                                          context.read<CleaningCubit>();
                                      cubit.selectService(offerItem.id);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => BlocProvider.value(
                                            value: cubit,
                                            child: const CleaningScreen(),
                                          ),
                                        ),
                                      );
                                      break;
                                    case "house shifting":
                                      final bookingCubit = context
                                          .read<HouseShiftingBookingCubit>();
                                      bookingCubit.selectService(offerItem.id);

                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => MultiBlocProvider(
                                            providers: [
                                              BlocProvider.value(
                                                value: bookingCubit,
                                              ),
                                              BlocProvider(
                                                create: (_) =>
                                                    getIt<HouseShiftingCubit>(),
                                              ),
                                            ],
                                            child: const HouseShiftingScreen(),
                                          ),
                                        ),
                                      );
                                      break;

                                    case "painting":
                                      final cubit =
                                          context.read<PaintingCubit>();
                                      cubit.selectService(offerItem.id);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => BlocProvider.value(
                                            value: cubit,
                                            child: const PaintingScreen(),
                                          ),
                                        ),
                                      );
                                      break;

                                    default:
                                      print(
                                          "Unknown service: ${offerItem.serviceName}");
                                  }
                                },
                              );
                            },
                          ),
                        )
                      else
                        const Center(child: Text("No offers available")),
                    ],
                  );
                }
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
                  final services = state.services.where((s) {
                    return s.name.toLowerCase() != "house shifting";
                  }).toList();

                  if (services.isEmpty) {
                    return HomeShimmerWidgets.buildServicesShimmer();
                  }

                  return SizedBox(
                    height: 110.h,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: services.length,
                      separatorBuilder: (_, __) => SizedBox(width: 10.w),
                      itemBuilder: (context, index) {
                        final service = services[index];
                        return OtherServiceCard(
                          title: service.name,
                          iconPath: service.imageUrl,
                          backgroundColor: Colors.transparent,
                          onTap: () {
                            switch (service.name.toLowerCase()) {
                              case "cleaning":
                                final cleaningCubit =
                                    context.read<CleaningCubit>();
                                cleaningCubit.selectService(service.id);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => BlocProvider.value(
                                      value: cleaningCubit,
                                      child: const CleaningScreen(),
                                    ),
                                  ),
                                );
                                break;

                              case "vehicle":
                                final vehicleCubit =
                                    context.read<VehicleCubit>();
                                vehicleCubit.selectService(service.id);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => BlocProvider.value(
                                      value: vehicleCubit,
                                      child: const VehicleScreen(),
                                    ),
                                  ),
                                );
                                break;

                              case "painting":
                                final paintingCubit =
                                    context.read<PaintingCubit>();
                                paintingCubit.selectService(service.id);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => BlocProvider.value(
                                      value: paintingCubit,
                                      child: const PaintingScreen(),
                                    ),
                                  ),
                                );
                                break;
                            }
                          },
                        );
                      },
                    ),
                  );
                }
                return HomeShimmerWidgets.buildServicesShimmer();
              },
            )
          ],
        ),
      ),
    );
  }
}
