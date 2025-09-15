import 'package:engzly/features/profile/data/models/main_profile_models/get_user_data_response_model.dart';

abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ChangePasswordLoading extends ProfileState {}

class ChangePasswordSuccess extends ProfileState {
  final String message;
  ChangePasswordSuccess(this.message);
}

class ChangePasswordError extends ProfileState {
  final String error;
  ChangePasswordError(this.error);
}


class UserDataLoading extends ProfileState {}

class UserDataSuccess extends ProfileState {
final GetUserDataResponseModel user; 
  UserDataSuccess(this.user);
}

class UserDataError extends ProfileState {
  final String error;
  UserDataError(this.error);
}


class UpdateUserDataLoading extends ProfileState {}

class UpdateUserDataSuccess extends ProfileState {
final String message; 
  UpdateUserDataSuccess(this.message);
}

class UpdateUserDataError extends ProfileState {
  final String error;
  UpdateUserDataError(this.error);
}

class ProfileImagePicked extends ProfileState {}

class SelectLocationSuccess extends ProfileState {
final String message; 
  SelectLocationSuccess(this.message);
}

class SelectLocationError extends ProfileState {
  final String error;
  SelectLocationError(this.error);
}



