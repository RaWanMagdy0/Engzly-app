import 'package:engzly/core/helper/local/secure_storage.dart';
import 'package:engzly/core/helper/local/token_manger.dart';
import 'package:engzly/core/networking/api/api_result.dart';
import 'package:engzly/core/networking/base_view_model.dart';
import 'package:engzly/features/auth/data/models/login/google_login_respose_model.dart';
import 'package:engzly/features/auth/data/repo/login/google_repo.dart';
import 'package:engzly/features/auth/logic/login_cubit/google.dart/google_states.dart';
import 'package:engzly/features/auth/ui/login/google_login/google_auth_service.dart';
import 'package:injectable/injectable.dart';

@injectable
class GoogleLoginCubit extends BaseViewModel<GoogleLoginState> {
  final GoogleLoginRepo _googleLoginRepo;
  final AuthService _googleAuthService;

  GoogleLoginCubit(
    this._googleLoginRepo,
    this._googleAuthService,
  ) : super(GoogleLoginInitial());

  Future<void> loginWithGoogle() async {
    emit(GoogleLoginLoading());

    try {
      final firebaseToken = await _googleAuthService.signInWithGoogle();

      if (firebaseToken == null) {
        emit(GoogleLoginError('تم إلغاء تسجيل الدخول'));
        return;
      }

      await SecureStorageFactory.writeData(
          key: 'googleIdToken', value: firebaseToken);

      final result = await _googleLoginRepo.googleLogin(firebaseToken);

      if (result is Success<GoogleLoginResposeModel>) {
        final response = result.data;

        if (response == null || !response.isSuccess) {
          emit(GoogleLoginError(response?.message ?? 'فشل تسجيل الدخول بجوجل'));
          return;
        }

        await TokenManager.setToken(token: response.token ?? "");
        await TokenManager.setRefreshToken(token: response.refreshToken ?? "");

        await SecureStorageFactory.writeData(
            key: 'token', value: response.token ?? "");

        if (response.email != null) {
          await SecureStorageFactory.writeData(
              key: 'userEmail', value: response.email!);
        }
        if (response.username != null) {
          await SecureStorageFactory.writeData(
              key: 'username', value: response.username!);
        }

        emit(GoogleLoginSuccess(response.username ?? 'تم تسجيل الدخول بنجاح!'));
      } else if (result is Fail) {
        emit(GoogleLoginError(
            getErrorMessageFromException((result as Fail).exception)));
      }
    } catch (error) {
      emit(GoogleLoginError('حدث خطأ أثناء تسجيل الدخول: $error'));
    }
  }
}
