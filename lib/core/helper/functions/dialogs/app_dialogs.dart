import 'package:engzly/core/theming/colors.dart';
import 'package:engzly/core/theming/fonts.dart';
import 'package:engzly/core/theming/images.dart';
import 'package:engzly/features/profile/logic/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class AppDialogs {
  static Future<void> showLoading({
    required BuildContext context,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return PopScope(
          canPop: false,
          child: Lottie.asset(
            AppImages.loading,
            height: 50.h,
            width: 20.w,
          ),
        );
      },
    );
  }

  static void showErrorDialog({
    required BuildContext context,
    required String errorMassage,
  }) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: ColorsManager.white,
        icon: Lottie.asset(AppImages.error, height: 110.h),
        content: Text(
          textAlign: TextAlign.center,
          errorMassage,
          style: AppFonts.font16BlackWeight400
              .copyWith(fontSize: 18.sp, fontWeight: FontWeight.w500),
        ),
        /************
                actions: [
                TextButton(
                onPressed: () {
                Navigator.of(context).pop();
                },
                child: Text(
                'Got it',
                style: AppFonts.font20BlackWeight400,
                ),
                ),
                ],
             ************/
      ),
    );
  }

  static void showSuccessDialog({
    required BuildContext context,
    required String message,

    VoidCallback? whenAnimationFinished,
  }) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: ColorsManager.white,
        icon: Lottie.asset(
          AppImages.success,
          height: 110.h,
          repeat: false,
          onLoaded: (composition) {
            Future.delayed(
              composition.duration,
              () {
                if (context.mounted) {
                  Navigator.of(context).pop();
                  if (whenAnimationFinished != null) {
                    whenAnimationFinished();
                  }
                }
              },
            );
          },
        ),
        content: Text(
          message,
          style: AppFonts.font16BlackWeight400
              .copyWith(fontSize: 18.sp, fontWeight: FontWeight.w500),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  static void showHideDialog(BuildContext context) {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
  }

  static void logoutDialog({
    required BuildContext context,
    required ProfileCubit cubit,
  }) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: ColorsManager.white,
        content: SizedBox(
          width: 240.w,
          height: 150.h,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              15.verticalSpace,
              Text(
                "LOGOUT",
                style: AppFonts.font16BlackWeight400
                    .copyWith(fontWeight: FontWeight.w600),
              ),
              5.verticalSpace,
              Text(
                "Confirm logout!!",
                style: AppFonts.font16BlackWeight400
                    .copyWith(fontWeight: FontWeight.w400),
              ),
              20.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(90.w, 45.h),
                      backgroundColor: ColorsManager.lightGray,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.r),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Cancel",
                      style: AppFonts.font14BWhiteWeight700
                          .copyWith(color: Colors.black),
                    ),
                  ),
                  12.horizontalSpace,
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(90.w, 45.h),
                      backgroundColor: ColorsManager.orange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.r),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      cubit.logout();
                    },
                    child: Text(
                      "Logout",
                      style: AppFonts.font14BWhiteWeight700,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
