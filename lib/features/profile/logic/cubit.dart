import 'dart:io';
import 'package:engzly/core/di/di.dart';
import 'package:engzly/core/helper/functions/providers/app_provider.dart';
import 'package:engzly/core/helper/local/secure_storage.dart';
import 'package:engzly/core/helper/local/token_manger.dart';
import 'package:engzly/core/networking/api/api_result.dart';
import 'package:engzly/core/networking/base_view_model.dart';
import 'package:engzly/features/profile/data/models/address/add_location_request_body.dart';
import 'package:engzly/features/profile/data/models/address/add_location_response_model.dart';
import 'package:engzly/features/profile/data/models/change_password_models/change_password_request_body.dart';
import 'package:engzly/features/profile/data/models/change_password_models/change_password_response_model.dart';
import 'package:engzly/features/profile/data/models/get_address/location_model.dart';
import 'package:engzly/features/profile/data/models/main_profile_models/get_user_data_response_model.dart';
import 'package:engzly/features/profile/data/models/update_user_data_models/update_user_data_request_body.dart';
import 'package:engzly/features/profile/data/repo/change_password_repo.dart';
import 'package:engzly/features/profile/data/repo/get_locations_repo.dart';
import 'package:engzly/features/profile/data/repo/get_user_data_repo.dart';
import 'package:engzly/features/profile/data/repo/location_repo.dart';
import 'package:engzly/features/profile/data/repo/update_user_data_repo.dart';
import 'package:engzly/features/profile/logic/state.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';

@injectable
class ProfileCubit extends BaseViewModel<ProfileState> {
  final ChangePasswordRepo _changePasswordRepo;
  final GetUserDataRepo _getUserDataRepo;
  final UpdateUserDataRepo _updateUserDataRepo;
  final LocationRepo _addLocationRepo;
  final GetLocationsRepo _getLocationsRepo;

  ProfileCubit(
    this._changePasswordRepo,
    this._getUserDataRepo,
    this._updateUserDataRepo,
    this._addLocationRepo,
    this._getLocationsRepo,
  ) : super(ProfileInitial());

  final formKey = GlobalKey<FormState>();
  final appProvider = getIt.get<AppProvider>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final fullNameController = TextEditingController();
  final addressController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final imageController = TextEditingController();

  String imageUrl = "";
  // ignore: prefer_typing_uninitialized_variables
  var user;
  File? selectedImage;

  List<LocationModel> locations = [];
  bool hasChanges = false;
  bool hasPasswordChanges = false;

  String? _originalName;
  String? _originalPhone;
  String? _originalAddress;

  void setPasswordChanges(bool value) {
    hasPasswordChanges = value;
    emit(ProfileHasPasswordChangesState());
  }

  void setHasChanges(bool value) {
    if (hasChanges != value) {
      hasChanges = value;
      emit(ProfileHasChangesState());
    }
  }

  void checkForChanges() {
    final isNameChanged =
        fullNameController.text.trim() != (_originalName ?? "");
    final isPhoneChanged =
        phoneNumberController.text.trim() != (_originalPhone ?? "");
    final isAddressChanged =
        addressController.text.trim() != (_originalAddress ?? "");
    final isImageChanged = selectedImage != null;

    final hasAnyChange =
        isNameChanged || isPhoneChanged || isAddressChanged || isImageChanged;
    setHasChanges(hasAnyChange);
  }

  Future<void> forgetPassword({
    required String password,
    required String newPassword,
    required String confirmPassword,
  }) async {
    emit(ChangePasswordLoading());
    final changePassRequest = ChangePasswordRequestBody(
      email: appProvider.email,
      password: password,
      newPassword: newPassword,
      confirmPassword: confirmPassword,
    );
    final result = await _changePasswordRepo.changePassword(changePassRequest);
    if (result is Success<ChangePasswordResponseModel>) {
      final response = result.data;
      emit(ChangePasswordSuccess(
        response?.message ?? "Password Changed Successfully",
      ));
    } else if (result is Fail) {
      final failResult = result as Fail;
      final errorMessage = getErrorMessageFromException(failResult.exception);
      emit(ChangePasswordError(errorMessage));
    }
  }

  Future<void> getUserData() async {
    emit(UserDataLoading());

    final result = await _getUserDataRepo.getUserData();
    if (result is Success<GetUserDataResponseModel>) {
      final response = result.data!;
      user = response;

      fullNameController.text = response.fullName ?? "";
      emailController.text = response.email ?? "";
      phoneNumberController.text = response.phoneNumber ?? "";
      addressController.text = response.address ?? "";
      appProvider.email = emailController.text;

      imageUrl = fixImageUrl(response.imageUrl);

      _originalName = response.fullName ?? "";
      _originalPhone = response.phoneNumber ?? "";
      _originalAddress = response.address ?? "";

      emit(UserDataSuccess(response));
    } else if (result is Fail) {
      final failResult = result as Fail;
      final errorMessage = getErrorMessageFromException(failResult.exception);
      emit(UserDataError(errorMessage));
    }
  }

  Future<void> updateUserData() async {
    emit(UpdateUserDataLoading());

    final body = UpdateUserDataRequestBody(
      fullNameController.text.isNotEmpty
          ? fullNameController.text
          : user.fullName,
      phoneNumberController.text.isNotEmpty
          ? phoneNumberController.text
          : user.phoneNumber,
      addressController.text.isNotEmpty
          ? addressController.text
          : user.cuurentAddress,
      image: selectedImage,
    );

    final result = await _updateUserDataRepo.updateUserData(body);

    if (result is Success<String>) {
      emit(UpdateUserDataSuccess(
          result.data ?? "User Data Updated Successfully"));

      _originalName = fullNameController.text;
      _originalPhone = phoneNumberController.text;
      _originalAddress = addressController.text;

      setHasChanges(false);
    } else if (result is Fail) {
      emit(UpdateUserDataError(
        getErrorMessageFromException((result as Fail).exception),
      ));
    }
  }

  Future<void> addLocation({
    required String type,
    required String location,
  }) async {
    final addLocationRequest = AddLocationRequestBody(
      type: type,
      location: location,
    );
    final result = await _addLocationRepo.selectLocation(addLocationRequest);
    if (result is Success<AddLocationResponseModel>) {
      final response = result.data;
      emit(SelectLocationSuccess(
        response?.message ?? "Add Location Successfully",
      ));
    } else if (result is Fail) {
      final failResult = result as Fail;
      final errorMessage = getErrorMessageFromException(failResult.exception);
      emit(SelectLocationError(errorMessage));
    }
  }

  Future<void> getLocations() async {
    emit(GetLocationsLoading());

    final result = await _getLocationsRepo.getLocations();

    if (result is Success<List<LocationModel>>) {
      locations = result.data!;
      emit(GetLocationsSuccess(locations));
    } else if (result is Fail) {
      final failResult = result as Fail;
      final errorMessage = getErrorMessageFromException(failResult.exception);
      emit(GetLocationsError(errorMessage));
    }
  }

  Future<void> logout() async {
    emit(LogoutLoading());
    try {
      await _updateUserDataRepo.revoke();

      await TokenManager.deleteToken();
      await SecureStorageFactory.deleteData(key: 'token');
      await SecureStorageFactory.deleteData(key: 'rememberMe');
      await SecureStorageFactory.deleteData(key: 'savedEmail');
      await SecureStorageFactory.deleteData(key: 'savedPassword');

      emit(LogoutSuccess());
    } catch (e) {
      emit(LogoutError(e.toString()));
    }
  }

  static String fixImageUrl(String? url) {
    if (url == null || url.isEmpty) return "";
    return url.replaceFirst(
      "http://engezly.runasp.net/http://engezly.runasp.net/",
      "http://engezly.runasp.net/",
    );
  }

  void setImage(File file) {
    selectedImage = file;
    checkForChanges();
    emit(ProfileImagePicked());
  }
}
