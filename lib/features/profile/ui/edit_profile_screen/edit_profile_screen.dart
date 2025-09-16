import 'package:cached_network_image/cached_network_image.dart';
import 'package:engzly/core/helper/image_helper.dart';
import 'package:engzly/core/routing/route_name.dart';
import 'package:engzly/core/shared_widgets/custom_scaffold.dart';
import 'package:engzly/core/theming/colors.dart';
import 'package:engzly/core/theming/fonts.dart';
import 'package:engzly/core/theming/images.dart';
import 'package:engzly/features/profile/logic/cubit.dart';
import 'package:engzly/features/profile/logic/state.dart';
import 'package:engzly/features/profile/ui/edit_profile_screen/widgets/edit_profile_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late ProfileCubit viewModel;
  @override
  void initState() {
    super.initState();
    viewModel = context.read<ProfileCubit>();
    viewModel.getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is UpdateUserDataSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                backgroundColor: Colors.green, content: Text(state.message)),
          );
        } else if (state is UpdateUserDataError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error)),
          );
        }
      },
      builder: (context, state) {
        final viewModel = context.read<ProfileCubit>();

        return CustomScaffoldScreen(
          title: Text(
            "Edit Profile ",
            style: AppFonts.font14BWhiteWeight700.copyWith(fontSize: 18.sp),
          ),
          leadingIcon: Icon(Icons.arrow_back, size: 28.w, color: Colors.white),
          notificationIcon: Image.asset(
            AppImages.notificationIcon,
            width: 28.w,
            height: 28.h,
          ),
          onLeadingTap: () {
            Navigator.pushNamed(context, RouteName.profile);
          },
          onNotificationTap: () {},
          showNotificationDot: true,
          child: Expanded(
            child: Column(
              children: [
                20.verticalSpace,
                Stack(
                  alignment: Alignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20.r),
                      child: viewModel.selectedImage != null
                          ? Image.file(
                              viewModel.selectedImage!,
                              width: 120.w,
                              height: 120.h,
                              fit: BoxFit.cover,
                            )
                          : CachedNetworkImage(
                              imageUrl:
                                  ProfileCubit.fixImageUrl(viewModel.imageUrl),
                              width: 120.w,
                              height: 120.h,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Center(
                                child:
                                    CircularProgressIndicator(strokeWidth: 2),
                              ),
                              errorWidget: (context, url, error) => Icon(
                                Icons.person,
                                size: 60.sp,
                                color: Colors.grey,
                              ),
                            ),
                    ),
                    Container(
                      width: 120.w,
                      height: 120.h,
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.4),
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        final imageFile = await ImageHelper.pickImage(
                            source: ImageSource.gallery);
                        if (imageFile != null) {
                          viewModel.setImage(imageFile);
                        }
                      },
                      icon: Icon(
                        Icons.camera_alt,
                        color: ColorsManager.lightGray,
                        size: 30.sp,
                      ),
                    ),
                  ],
                ),
                EditProfileForm(viewModel: viewModel),
              ],
            ),
          ),
        );
      },
    );
  }
}
