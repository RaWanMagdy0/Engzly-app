import 'package:engzly/core/networking/api/api_result.dart';
import 'package:engzly/core/networking/api/execute_api_call.dart';
import 'package:engzly/features/auth/data/auth_api/auth_api_manager.dart';
import 'package:engzly/features/auth/data/models/verify_email/verify_email_request_model.dart';
import 'package:engzly/features/auth/data/models/verify_email/verify_email_response_model.dart';
import 'package:injectable/injectable.dart';

@injectable
class VerifyEmailRepo {
  final AuthApiManager _apiManager;

  VerifyEmailRepo(this._apiManager);

  Future<Result<VerifyEmailResponseModel>> verifyEmail(
    VerifyEmailRequestModel verifyEmailRequestModel,
  ) {
    return executeApiCall<VerifyEmailResponseModel>(() async {
      final response = await _apiManager.verifyEmail(verifyEmailRequestModel);
      return response;
    });
  }
}
