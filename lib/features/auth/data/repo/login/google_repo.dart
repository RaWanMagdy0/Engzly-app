import 'package:engzly/core/helper/local/token_manger.dart';
import 'package:engzly/core/networking/api/api_result.dart';
import 'package:engzly/core/networking/api/execute_api_call.dart';
import 'package:engzly/features/auth/data/auth_api/auth_api_manager.dart';
import 'package:engzly/features/auth/data/models/login/google_login_respose_model.dart';
import 'package:injectable/injectable.dart';

@injectable
class GoogleLoginRepo {
  final AuthApiManager _apiManager;

  GoogleLoginRepo(this._apiManager);

  Future<Result<GoogleLoginResposeModel>> googleLogin(String googleToken) {
    return executeApiCall<GoogleLoginResposeModel>(() async {
      final response = await _apiManager.googleLogin("Bearer $googleToken");

      final token = response.token;
      if (token != null && token.isNotEmpty) {
        await TokenManager.setToken(token: token);
      }
      final refreshToken = response.refreshToken;
      if (refreshToken != null && refreshToken.isNotEmpty) {
        await TokenManager.setRefreshToken(token: refreshToken);
      }

      return response;
    });
  }
}
