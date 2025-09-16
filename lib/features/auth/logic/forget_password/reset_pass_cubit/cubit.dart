
import 'package:engzly/core/di/di.dart';
import 'package:engzly/core/helper/functions/providers/app_provider.dart';
import 'package:engzly/core/networking/api/api_result.dart';
import 'package:engzly/features/auth/data/models/reset_password/reset_password_request_body.dart';
import 'package:engzly/features/auth/data/models/reset_password/reset_password_response_model.dart';
import 'package:engzly/core/networking/base_view_model.dart';
import 'package:engzly/features/auth/data/repo/forget_password/reset_password_repo.dart';
import 'package:engzly/features/auth/logic/forget_password/reset_pass_cubit/states.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';

@injectable
class ResetPasswordCubit extends BaseViewModel<ResetPasswordState> {
  final ResetPasswordRepo _resetPasswordRepo;

  ResetPasswordCubit(this._resetPasswordRepo) : super(ResetPasswordInitial());

  final formKey = GlobalKey<FormState>();
    final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final appProvider = getIt.get<AppProvider>();

  Future<void> resetPassword({required String newPassword,required String confirmPassword}) async {
    emit(ResetPasswordLoading());
    final resetPasswordResponseModel = ResetPasswordRequestBody(
      newPassword: newPassword,
      confirmPassword: confirmPassword,
      email: appProvider.email
    );
    final result = await _resetPasswordRepo.resetPassword(resetPasswordResponseModel);
    if (result is Success<ResetPasswordResponseModel>) {
      final response = result.data;
  
      emit(ResetPasswordSuccess(
          response?.result ?? "Verfication Code sent.Please Check Your Email"));
    } else if (result is Fail) {
      final failResult = result as Fail;
      final errorMessage = getErrorMessageFromException(failResult.exception);
      emit(ResetPasswordError(errorMessage));
    }
  }
}
