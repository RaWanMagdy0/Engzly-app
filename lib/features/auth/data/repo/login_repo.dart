import 'package:engzly/core/helper/local/token_manger.dart';
import 'package:engzly/core/networking/api/api_result.dart';
import 'package:engzly/core/networking/api/execute_api_call.dart';
import 'package:engzly/features/auth/data/auth_api/auth_api_manager.dart';
import 'package:engzly/features/auth/data/models/login/login_request_model.dart';
import 'package:engzly/features/auth/data/models/login/login_response_model.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoginRepo {
  final AuthApiManager _apiManager;

  LoginRepo(this._apiManager);

  Future<Result<LoginResponseModel>> login(
    LoginRequestModel loginRequestModel,
  ) {
    return executeApiCall<LoginResponseModel>(() async {
      final response = await _apiManager.login(
        loginRequestModel.email,
        loginRequestModel.password,
      );
      final token = response.token;
      if (token != null && token.isNotEmpty) {
        await TokenManager.setToken(token: token);
      }
      return response;
    });
  }
}
