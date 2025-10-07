import 'package:engzly/core/helper/local/secure_storage.dart';
import 'package:engzly/core/helper/local/token_manger.dart';
import 'package:engzly/core/networking/api/api_result.dart';
import 'package:engzly/features/auth/data/models/login/login_request_model.dart';
import 'package:engzly/features/auth/data/models/login/login_response_model.dart';
import 'package:engzly/features/auth/data/repo/login_repo.dart';
import 'package:engzly/core/networking/base_view_model.dart';
import 'package:engzly/features/auth/logic/login_cubit/states.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoginCubit extends BaseViewModel<LoginState> {
  final LoginRepo _loginRepo;

  LoginCubit(this._loginRepo) : super(LoginInitial());

  Future<void> login({
    required String email,
    required String password,
    required bool rememberMe,
  }) async {
    emit(LoginLoading());

    final loginRequest = LoginRequestModel(email: email, password: password);

    final result = await _loginRepo.login(loginRequest);

    if (result is Success<LoginResponseModel>) {
      final response = result.data;
      final token = response?.token ?? "";
      final refreshToken = response?.refreshToken ?? "";

      await TokenManager.setToken(token: token);
      await TokenManager.setRefreshToken(token: refreshToken);
      await SecureStorageFactory.writeData(key: 'token', value: token);

      if (rememberMe) {
        await SecureStorageFactory.writeData(key: 'rememberMe', value: 'true');
        await SecureStorageFactory.writeData(key: 'savedEmail', value: email);
        await SecureStorageFactory.writeData(
            key: 'savedPassword', value: password);
      } else {
        await SecureStorageFactory.writeData(key: 'rememberMe', value: 'false');
        await SecureStorageFactory.deleteData(key: 'savedEmail');
        await SecureStorageFactory.deleteData(key: 'savedPassword');
      }

      emit(LoginSuccess(response?.username ?? "Logged in successfully"));
    } else if (result is Fail) {
      final failResult = result as Fail;
      final errorMessage = getErrorMessageFromException(failResult.exception);
      emit(LoginError(errorMessage));
    }
  }
}
