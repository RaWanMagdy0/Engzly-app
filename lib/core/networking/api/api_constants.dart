class ApiConstants {
  static const String baseUrl = "http://engezly.runasp.net/api/";
  // --------------------  auth  -----------------
  static const String login = "Auth/login";
  static const String register = "Auth/Register";
  static const String confirmEmail = "Auth/confirm-email";

  static const String forgetPassword = "Auth/ForgetPassword";
  static const String verifiEmail = "Auth/ForgetPassVerfication";
  static const String resetPassword = "Auth/ForgetPasschange";
  static const String revoke = "Auth/revoke";

  // --------------------  User  -----------------

  static const String getUserData = "User/GetUserDataForEdit";
  static const String updateUserData = "User/Put User data for Update";
  static const String changePassword = "User/ChangePassword";

  static const String selectLocation = "User/addLocation";
  static const String getLocations = "HouseShifting/UserLocations";

  // --------------------  Home  -----------------

  static const String getOffers = "Home/GetOffer&News";
  static const String getservice = "Home/GetOtherServices";
  static const String getHistory = "User/bookings";
  static const String getHouseSize = "HouseShifting/HouseSize";
  static const String getFurnitures = "HouseShifting/Furnitures";
  static const String getVehicles = "HouseShifting/Vehicles";
  static const String checkPromoCode = "HouseShifting/check-promocode";
  static const String checkOut = "Booking/HouseShifting";

  static const String resendResetOtp = "auth/resend-reset-otp";
  static const String refreshToken = "Auth/refresh";
  static const String revokeToken = "Auth/revoke";
}
