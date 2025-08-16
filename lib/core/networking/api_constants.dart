class ApiConstants {
  static const String baseUrl = "";
  // --------------------  auth  -----------------
  static const String login = "auth/login";
  static const String register = "auth/register";
  static const String resendOtp = "auth/resend-otp";
  static const String resendResetOtp = "auth/resend-reset-otp";
  static const String verifyEmail = "auth/verify-email";
  static const String forgetPassword = "auth/forgot-password";
  static const String resetPassword = "auth/reset-password";
  static const String refreshToken = "auth/refresh-token";
  // --------------------  profile  -----------------
  static const String fetchUserInfo = "users/me";
  static const String updateUserInfo = "users/me";
}
