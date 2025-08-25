import 'package:engzly/core/networking/api/api_result.dart';
import 'package:engzly/features/auth/data/models/login/login_request_model.dart';
import 'package:engzly/features/auth/data/models/login/login_response_model.dart';
import 'package:engzly/features/auth/data/repo/login_repo.dart';
import 'package:engzly/features/auth/logic/states.dart';
import 'package:engzly/core/networking/base_view_model.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoginCubit extends BaseViewModel<LoginState> {
  final LoginRepo _loginRepo;

  LoginCubit(this._loginRepo) : super(LoginInitial());

  Future<void> login({required String email, required String password}) async {
    emit(LoginLoading());

    final loginRequest = LoginRequestModel(email: email, password: password);

    final result = await _loginRepo.login(loginRequest);

    if (result is Success<LoginResponseModel>) {
      final response = result.data;


      /***** 
       await SecureStorageFactory.writeData(
        key: 'token',
        value: response?.token ?? "",
      ); 
      */
     
      emit(LoginSuccess(response?.username ?? "Logged in successfully"));
    } else if (result is Fail) {
      final failResult = result as Fail;

      final errorMessage = getErrorMessageFromException(failResult.exception);
      
      emit(LoginError(errorMessage));
    }
  }
}
