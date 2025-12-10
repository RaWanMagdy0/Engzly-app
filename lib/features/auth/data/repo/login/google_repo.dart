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
      print("📡 Calling Backend with Google OAuth Token...");
      print("🔑 Token Type: ${googleToken.contains('accounts.google.com') ? 'Google OAuth ✅' : 'Unknown ⚠️'}");
      print("🔑 Token (First 100 chars): ${googleToken.substring(0, googleToken.length > 100 ? 100 : googleToken.length)}...");
      
      final response = await _apiManager.googleLogin("Bearer $googleToken");

      print("📦 Backend Response:");
      print("   - isSuccess: ${response.isSuccess}");
      print("   - message: ${response.message}");
      
      if (response.isSuccess) {
        print("   - email: ${response.email}");
        print("   - username: ${response.username}");
        print("   - token length: ${response.token?.length ?? 0}");
        
        final token = response.token;
        if (token != null && token.isNotEmpty) {
          await TokenManager.setToken(token: token);
          print("✅ Token saved in TokenManager");
        }
        
        final refreshToken = response.refreshToken;
        if (refreshToken != null && refreshToken.isNotEmpty) {
          await TokenManager.setRefreshToken(token: refreshToken);
          print("✅ Refresh Token saved in TokenManager");
        }
      } else {
        print("   - Error Message: ${response.message}");
      }

      return response;
    });
  }
}