import 'package:engzly/core/networking/api/api_result.dart';
import 'package:engzly/core/networking/api/execute_api_call.dart';
import 'package:engzly/features/auth/data/auth_api/auth_api_manager.dart';
import 'package:engzly/features/auth/data/models/reset_password/reset_password_request_body.dart';
import 'package:engzly/features/auth/data/models/reset_password/reset_password_response_model.dart';
import 'package:injectable/injectable.dart';

@injectable
class ResetPasswordRepo {
  final AuthApiManager _apiManager;

  ResetPasswordRepo(this._apiManager);

  Future<Result<ResetPasswordResponseModel>> resetPassword(
    ResetPasswordRequestBody resetPasswordRequestBody,
  ) {
    return executeApiCall<ResetPasswordResponseModel>(() async {
      final response =
          await _apiManager.resetPassword(resetPasswordRequestBody);
      return response;
    });
  }
}
