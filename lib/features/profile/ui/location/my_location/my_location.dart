import 'package:engzly/core/routing/route_name.dart';
import 'package:engzly/core/shared_widgets/custom_botton.dart';
import 'package:engzly/core/shared_widgets/custom_scaffold.dart';
import 'package:engzly/core/theming/colors.dart';
import 'package:engzly/core/theming/fonts.dart';
import 'package:engzly/core/theming/images.dart';
import 'package:engzly/features/profile/logic/cubit.dart';
import 'package:engzly/features/profile/logic/state.dart';
import 'package:engzly/features/profile/ui/location/my_location/widgets/location_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class MyLocation extends StatelessWidget {
  const MyLocation({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        final cubit = context.read<ProfileCubit>();
        return CustomScaffoldScreen(
          title: Text(
            "My Locations ",
            style: AppFonts.font14BWhiteWeight700.copyWith(fontSize: 18.sp),
          ),
          leadingIcon: SvgPicture.asset(
            AppImages.categoryIcon,
            width: 22.w,
            height: 22.h,
          ),
          notificationIcon: Image.asset(
            AppImages.notificationIcon,
            width: 28.w,
            height: 28.h,
          ),
          onLeadingTap: () {},
          onNotificationTap: () {},
          showNotificationDot: true,
          child: Column(
            children: [
              20.verticalSpace,
              Expanded(child: _buildBody(state, cubit)),
              CustomButton(
                onPressed: () {
                  Navigator.pushNamed(context, RouteName.addLocation);
                },
                color: ColorsManager.orange,
                textStyle: AppFonts.font14BWhiteWeight700,
                height: 55.h,
                width: 300.w,
                borderRadius: 25.r,
                child: Text(
                  "Add New Location",
                  style: AppFonts.font14BWhiteWeight700,
                ),
              ),
              20.verticalSpace,
            ],
          ),
        );
      },
    );
  }

  Widget _buildBody(ProfileState state, ProfileCubit cubit) {
    if (state is GetLocationsLoading) {
      return Center(
          child: CircularProgressIndicator(
        color: ColorsManager.orange,
      ));
    } else if (state is GetLocationsError) {
      return Center(
        child: Text(
          state.message,
          style: const TextStyle(color: Colors.red),
        ),
      );
    } else if (state is GetLocationsSuccess) {
      if (state.locations.isEmpty) {
        return const Center(child: Text("No locations found"));
      }
      return RefreshIndicator(
        onRefresh: () async {
          await cubit.getLocations();
        },
        child: ListView.separated(
          padding: EdgeInsets.all(16.w),
          itemCount: state.locations.length,
          separatorBuilder: (_, __) => 20.verticalSpace,
          itemBuilder: (context, index) {
            final loc = state.locations[index];
            return LocationCard(
              title: loc.type,
              address: loc.location,
              onTap: () {},
            );
          },
        ),
      );
    }
    return const SizedBox.shrink();
  }
}
