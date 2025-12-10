import 'package:engzly/core/helper/local/secure_storage.dart';
import 'package:engzly/core/networking/api/api_result.dart';
import 'package:engzly/core/networking/base_view_model.dart';
import 'package:engzly/features/auth/data/models/login/google_login_respose_model.dart';
import 'package:engzly/features/auth/data/repo/login/google_repo.dart';
import 'package:engzly/features/auth/logic/login_cubit/google.dart/google_states.dart';
import 'package:engzly/features/auth/ui/login/google_login/google_auth_service.dart';
import 'package:injectable/injectable.dart';

@injectable
class GoogleLoginCubit extends BaseViewModel<GoogleLoginState> {
  final AuthService _googleAuthService;
  final GoogleLoginRepo _loginRepo;

  GoogleLoginCubit(
    this._googleAuthService,
    this._loginRepo,
  ) : super(GoogleLoginInitial());

  Future<void> loginWithGoogle() async {
    emit(GoogleLoginLoading());

    try {
      print("🚀 Starting Google Login...");
      
      final user = await _googleAuthService.signInWithGoogle();

      if (user == null) {
        print("❌ User cancelled or Sign In failed");
        emit(GoogleLoginError("Google sign-in was cancelled."));
        return;
      }

      print("✅ Firebase User: ${user.email}");

      final tokens = await _googleAuthService.getGoogleTokens();
      final String? googleIdToken = tokens['idToken'];
      
      if (googleIdToken == null || googleIdToken.isEmpty) {
        print("❌ Failed to get Google ID Token");
        emit(GoogleLoginError("Failed to get Google authentication token."));
        return;
      }

      print("🔑 Google ID Token (First 100 chars): ${googleIdToken.substring(0, googleIdToken.length > 100 ? 100 : googleIdToken.length)}...");
      
      print("📊 Token Info:");
      print("   - Length: ${googleIdToken.length}");
      print("   - Type: Google OAuth ID Token");
      
      if (googleIdToken.contains('securetoken.google.com')) {
        print("⚠️ WARNING: This looks like a Firebase token!");
        print("⚠️ Backend expects Google OAuth token, not Firebase token!");
      } else if (googleIdToken.contains('accounts.google.com')) {
        print("✅ Confirmed: This is a Google OAuth token");
      }
      final result = await _loginRepo.googleLogin(googleIdToken);

      if (result is Success<GoogleLoginResposeModel>) {
        final response = (result).data;
        
        if (response == null) {
          print("❌ Response data is null");
          emit(GoogleLoginError("Invalid response from server."));
          return;
        }

        print("📦 Response:");
        print("   - isSuccess: ${response.isSuccess}");
        print("   - message: ${response.message}");
        print("   - email: ${response.email}");

        if (!response.isSuccess) {
          print("❌ Backend returned failure");
          emit(GoogleLoginError(response.message ?? "Login failed"));
          return;
        }

        final token = response.token ?? "";

        if (token.isEmpty) {
          print("❌ Token is empty");
          emit(GoogleLoginError("Server returned empty token."));
          return;
        }

        await SecureStorageFactory.writeData(key: 'token', value: token);
        print("✅ Token saved in SecureStorage");
        
        if (response.email != null) {
          await SecureStorageFactory.writeData(key: 'userEmail', value: response.email!);
        }

        print("✅✅✅ Google Login Success! ✅✅✅");

        emit(GoogleLoginSuccess(
          name: response.username ?? user.displayName ?? "User",
          email: response.email ?? user.email ?? "",
          imageUrl: response.image ?? user.photoURL ?? "",
        ));
      } else if (result is Fail) {
        final failResult = result as Fail;
        final errorMessage = getErrorMessageFromException(failResult.exception);
        print("❌ Backend Error: $errorMessage");
        emit(GoogleLoginError(errorMessage));
      }
    } catch (e, stackTrace) {
      print("❌ Google Login Error: $e");
      print("Stack trace: $stackTrace");
      emit(GoogleLoginError("An unexpected error occurred: ${e.toString()}"));
    }
  }
}