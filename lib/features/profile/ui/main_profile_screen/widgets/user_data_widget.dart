import 'package:engzly/core/theming/colors.dart';
import 'package:engzly/core/theming/fonts.dart';
import 'package:engzly/features/profile/data/models/main_profile_models/get_user_data_response_model.dart';
import 'package:engzly/features/profile/logic/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';

class UserDataWidget extends StatelessWidget {
  const UserDataWidget({super.key, required this.user});
  final GetUserDataResponseModel user;

  @override
  Widget build(BuildContext context) {
    final fixedUrl = ProfileCubit.fixImageUrl(user.imageUrl);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15.r),
            child: CachedNetworkImage(
              imageUrl: fixedUrl,
              width: 120.w,
              height: 120.h,
              fit: BoxFit.cover,
              placeholder: (context, url) => Shimmer.fromColors(
                baseColor: ColorsManager.lightGray.withValues(alpha: 0.3),
                highlightColor: Colors.white,
                child: Container(
                  width: 120.w,
                  height: 120.h,
                  color: ColorsManager.lightGray,
                ),
              ),
              errorWidget: (context, url, error) =>
                  Icon(Icons.person, size: 80.w, color: Colors.grey),
            ),
          ),
          SizedBox(height: 5.h),
          Text(
            user.fullName?.isNotEmpty == true ? user.fullName! : "No Name",
            style: AppFonts.font20BlackWeight700.copyWith(fontSize: 18.sp),
          ),
          Text(
            user.email ?? "No Email",
            style: AppFonts.font14BOrangeWeight400,
          ),
          
        ],
      ),
    );
  }
}
