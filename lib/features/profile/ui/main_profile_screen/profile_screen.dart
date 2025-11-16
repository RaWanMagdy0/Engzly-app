import 'package:engzly/core/routing/route_name.dart';
import 'package:engzly/core/shared_widgets/custom_botton.dart';
import 'package:engzly/core/shared_widgets/custom_scaffold.dart';
import 'package:engzly/core/theming/colors.dart';
import 'package:engzly/core/theming/fonts.dart';
import 'package:engzly/features/profile/logic/cubit.dart';
import 'package:engzly/features/profile/logic/state.dart';
import 'package:engzly/features/profile/ui/main_profile_screen/widgets/general_data_widget.dart';
import 'package:engzly/features/profile/ui/main_profile_screen/widgets/more_widget.dart';
import 'package:engzly/features/profile/ui/main_profile_screen/widgets/notification_widget.dart';
import 'package:engzly/features/profile/ui/main_profile_screen/widgets/user_data_shimmer.dart';
import 'package:engzly/features/profile/ui/main_profile_screen/widgets/user_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:engzly/core/theming/images.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late ProfileCubit viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = context.read<ProfileCubit>();
    if (viewModel.state is! UserDataSuccess) {
      viewModel.getUserData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldScreen(
        title: Text(
          "Profile ",
        ),
        leadingIcon: SvgPicture.asset(AppImages.categoryIcon,
            width: 22.w, height: 22.h, color: ColorsManager.black),
        notificationIcon: Image.asset(AppImages.notificationIcon,
            width: 28.w, height: 28.h, color: ColorsManager.black),
        onLeadingTap: () {
          //     Navigator.pushNamed(context, RouteName.homeLayout);
        },
        onNotificationTap: () {},
        child: Column(children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  BlocConsumer<ProfileCubit, ProfileState>(
                    bloc: viewModel,
                    listener: (context, state) {
                      if (state is UserDataError) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(state.error),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    },
                    builder: (context, state) {
                      if (state is UserDataLoading) {
                        return const UserDataShimmerWidget();
                      } else if (state is UserDataSuccess) {
                        return UserDataWidget(user: state.user);
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                  CustomButton(
                    text: "Edit",
                    onPressed: () async {
                      final cubit = context.read<ProfileCubit>();
                      if (cubit.state is UserDataSuccess) {
                        final result = await Navigator.pushNamed(
                            context, RouteName.editProfile);

                        if (result == true) {
                          await cubit.getUserData();
                        }
                      } else {
                        await cubit.getUserData();
                        if (cubit.state is UserDataSuccess) {
                          final result = await Navigator.pushNamed(
                              context, RouteName.editProfile);
                          if (result == true) {
                            await cubit.getUserData();
                          }
                        } else if (cubit.state is UserDataError) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content:
                                  Text((cubit.state as UserDataError).error),
                            ),
                          );
                        }
                      }
                    },
                    width: 100.w,
                    height: 40.h,
                    backgroundColor: ColorsManager.white,
                    textStyle: AppFonts.font16BlackWeight400.copyWith(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    borderColor: ColorsManager.orange,
                    borderRadius: 25.r,
                  ),
                  GeneralDataWidget(),
                  NotificationWidget(),
                  MoreWidget(),
                ],
              ),
            ),
          )
        ]));
  }
}
