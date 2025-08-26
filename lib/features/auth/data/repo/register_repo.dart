import 'package:engzly/core/networking/api/api_result.dart';
import 'package:engzly/core/networking/api/execute_api_call.dart';
import 'package:engzly/features/auth/data/auth_api/auth_api_manager.dart';
import 'package:engzly/features/auth/data/models/signup/register_request_body.dart';
import 'package:engzly/features/auth/data/models/signup/register_response_model.dart';
import 'package:injectable/injectable.dart';

@injectable
class RegisterRepo {
  final AuthApiManager _apiManager;

  RegisterRepo(this._apiManager);

  Future<Result<RegisterResponseModel>> register(
    RegisterRequestBody signupRequestModel,
  ) {
    return executeApiCall<RegisterResponseModel>(() async {
      final response = await _apiManager.register(signupRequestModel);
      return response;
    });
  }
}
