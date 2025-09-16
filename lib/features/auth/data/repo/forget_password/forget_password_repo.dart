import 'package:engzly/core/networking/api/api_result.dart';
import 'package:engzly/core/networking/api/execute_api_call.dart';
import 'package:engzly/features/auth/data/auth_api/auth_api_manager.dart';
import 'package:engzly/features/auth/data/models/forget_password/forget_password_request_body.dart'
    show ForgetPasswordRequestBody;
import 'package:engzly/features/auth/data/models/forget_password/forget_password_response_model.dart';
import 'package:injectable/injectable.dart';

@injectable
class ForgetPasswordRepo {
  final AuthApiManager _apiManager;

  ForgetPasswordRepo(this._apiManager);

  Future<Result<ForegtPasswordResponseModel>> forgetPassword(
    ForgetPasswordRequestBody confirmEmailRequestBody,
  ) {
    return executeApiCall<ForegtPasswordResponseModel>(() async {
      final response =
          await _apiManager.forgetPassword(confirmEmailRequestBody);
      return response;
    });
  }
}
