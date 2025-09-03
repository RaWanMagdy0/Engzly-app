import 'package:engzly/core/di/di.dart';
import 'package:engzly/core/helper/functions/providers/app_provider.dart';
import 'package:engzly/core/networking/api/api_result.dart';
import 'package:engzly/core/networking/base_view_model.dart';
import 'package:engzly/features/profile/data/models/change_password_request_body.dart';
import 'package:engzly/features/profile/data/models/change_password_response_model.dart';
import 'package:engzly/features/profile/data/repo/change_password_repo.dart';
import 'package:engzly/features/profile/logic/state.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';

@injectable
class ProfileCubit extends BaseViewModel<ChangePasswordState> {
  final ChangePasswordRepo _changePasswordRepo;

  ProfileCubit(this._changePasswordRepo) : super(ChangePasswordInitial());

  final formKey = GlobalKey<FormState>();
  final appProvider = getIt.get<AppProvider>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

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
        confirmPassword: confirmPassword);
    final result = await _changePasswordRepo.changePassword(changePassRequest);
    if (result is Success<ChangePasswordResponseModel>) {
      final response = result.data;

      emit(ChangePasswordSuccess(
          response?.message ?? "Password Changed Successfully"));
    } else if (result is Fail) {
      final failResult = result as Fail;
      final errorMessage = getErrorMessageFromException(failResult.exception);
      emit(ChangePasswordError(errorMessage));
    }
  }
}
