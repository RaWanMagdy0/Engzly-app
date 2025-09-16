class ApiConstants {
  static const String baseUrl = "http://engezly.runasp.net/api/";
  // --------------------  auth  -----------------
  static const String login = "Auth/login";
  static const String register = "Auth/Register";
  static const String confirmEmail = "Auth/confirm-email";

  static const String forgetPassword = "Auth/ForgetPassword";
  static const String verifiEmail = "Auth/ForgetPassVerfication";
  static const String resetPassword = "Auth/ForgetPasschange";

  static const String getUserData = "User/GetUserDataForEdit";
  static const String updateUserData = "User/Put User data for Update";
  static const String changePassword = "User/ChangePassword";

  static const String selectLocation = "User/addLocation";
  static const String getLocations = "User/UserLocations";

  static const String resendResetOtp = "auth/resend-reset-otp";
  static const String refreshToken = "Auth/refresh";
  static const String revokeToken = "Auth/revoke";
}
