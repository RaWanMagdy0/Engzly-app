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

      final token = response?.token;
      await TokenManager.setToken(token: response?.token);
      await TokenManager.setRefreshToken(token: response?.refreshToken);

      if (rememberMe && token != null && token.isNotEmpty) {
        await SecureStorageFactory.writeData(
          key: 'token',
          value: token,
        );
        await SecureStorageFactory.writeData(
          key: 'refreshToken',
          value: response?.refreshToken ?? "",
        );
      } else {
        await SecureStorageFactory.deleteData(key: 'token');
        await SecureStorageFactory.deleteData(key: 'refreshToken');
      }

      emit(LoginSuccess(response?.username ?? "Logged in successfully"));
    } else if (result is Fail) {
      final failResult = result as Fail;
      final errorMessage = getErrorMessageFromException(failResult.exception);
      emit(LoginError(errorMessage));
    }
  }
}
