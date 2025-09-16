import 'package:engzly/core/di/di.dart';
import 'package:engzly/core/helper/functions/providers/app_provider.dart';
import 'package:engzly/core/networking/api/api_result.dart';
import 'package:engzly/features/auth/data/models/forget_password/forget_password_request_body.dart';
import 'package:engzly/features/auth/data/models/forget_password/forget_password_response_model.dart';
import 'package:engzly/features/auth/data/repo/forget_password/forget_password_repo.dart';
import 'package:engzly/core/networking/base_view_model.dart';
import 'package:engzly/features/auth/logic/forget_password/forget_pass_cubit/states.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';

@injectable
class ForgetPasswordCubit extends BaseViewModel<ForgetPasswordState> {
  final ForgetPasswordRepo _forgetPasswordRepo;

  ForgetPasswordCubit(this._forgetPasswordRepo)
      : super(ForgetPasswordInitial());
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  final appProvider = getIt.get<AppProvider>();

  Future<void> forgetPassword({required String email}) async {
    emit(ForgetPasswordLoading());
    final forgetPassRequest = ForgetPasswordRequestBody(email: email);
    final result = await _forgetPasswordRepo.forgetPassword(forgetPassRequest);
    if (result is Success<ForegtPasswordResponseModel>) {
      final response = result.data;
      email = emailController.text;
      appProvider.email = email;

      emit(ForgetPasswordSuccess(
          response?.result ?? "Verfication Code sent.Please Check Your Email"));
    } else if (result is Fail) {
      final failResult = result as Fail;
      final errorMessage = getErrorMessageFromException(failResult.exception);
      emit(ForgetPasswordError(errorMessage));
    }
  }
}
