import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Helper class for common ScreenUtil operations
class ScreenUtilHelper {
  /// Get screen width
  static double get screenWidth => ScreenUtil().screenWidth;
  
  /// Get screen height
  static double get screenHeight => ScreenUtil().screenHeight;
  
  /// Get status bar height
  static double get statusBarHeight => ScreenUtil().statusBarHeight;
  
  /// Get bottom bar height
  static double get bottomBarHeight => ScreenUtil().bottomBarHeight;
  
  /// Get pixel ratio
  static double get pixelRatio => ScreenUtil().pixelRatio ?? 1.0;
  
  /// Get text scale factor
  static double get textScaleFactor => ScreenUtil().textScaleFactor;
  
  /// Check if device is tablet
  static bool get isTablet => ScreenUtil().screenWidth > 600;
  
  /// Check if device is phone
  static bool get isPhone => ScreenUtil().screenWidth <= 600;
  
  /// Get responsive width based on percentage
  static double responsiveWidth(double percentage) => 
      ScreenUtil().screenWidth * (percentage / 100);
  
  /// Get responsive height based on percentage
  static double responsiveHeight(double percentage) => 
      ScreenUtil().screenHeight * (percentage / 100);
  
  /// Get responsive font size
  static double responsiveFontSize(double size) => size.sp;
  
  /// Get responsive padding
  static EdgeInsets responsivePadding({
    double? all,
    double? horizontal,
    double? vertical,
    double? left,
    double? top,
    double? right,
    double? bottom,
  }) {
    if (all != null) {
      return EdgeInsets.all(all.w);
    }
    return EdgeInsets.only(
      left: left?.w ?? 0,
      top: top?.h ?? 0,
      right: right?.w ?? 0,
      bottom: bottom?.h ?? 0,
    );
  }
  
  /// Get responsive margin
  static EdgeInsets responsiveMargin({
    double? all,
    double? horizontal,
    double? vertical,
    double? left,
    double? top,
    double? right,
    double? bottom,
  }) {
    if (all != null) {
      return EdgeInsets.all(all.w);
    }
    return EdgeInsets.only(
      left: left?.w ?? 0,
      top: top?.h ?? 0,
      right: right?.w ?? 0,
      bottom: bottom?.h ?? 0,
    );
  }
  
  /// Get responsive radius
  static Radius responsiveRadius(double radius) => Radius.circular(radius.r);
  
  /// Get responsive border radius
  static BorderRadius responsiveBorderRadius({
    double? all,
    double? topLeft,
    double? topRight,
    double? bottomLeft,
    double? bottomRight,
  }) {
    if (all != null) {
      return BorderRadius.all(Radius.circular(all.r));
    }
    return BorderRadius.only(
      topLeft: Radius.circular((topLeft ?? 0).r),
      topRight: Radius.circular((topRight ?? 0).r),
      bottomLeft: Radius.circular((bottomLeft ?? 0).r),
      bottomRight: Radius.circular((bottomRight ?? 0).r),
    );
  }
}
