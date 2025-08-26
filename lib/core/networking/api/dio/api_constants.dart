class ApiConstants {
  static const String baseUrl = "http://engezly.runasp.net/api/";
  // --------------------  auth  -----------------
  static const String login = "Auth/login";
  static const String register = "Auth/Register";
  static const String confirmEmail = "Auth/confirm-email";

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
