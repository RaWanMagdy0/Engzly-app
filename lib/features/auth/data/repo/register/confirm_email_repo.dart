import 'package:engzly/core/networking/api/api_result.dart';
import 'package:engzly/core/networking/api/execute_api_call.dart';
import 'package:engzly/features/auth/data/auth_api/auth_api_manager.dart';
import 'package:engzly/features/auth/data/models/confirm_email/confirm_email_request_body.dart';
import 'package:engzly/features/auth/data/models/confirm_email/confirm_email_response_model.dart';
import 'package:injectable/injectable.dart';

@injectable
class ConfirmEmailRepo {
  final AuthApiManager _apiManager;

  ConfirmEmailRepo(this._apiManager);

  Future<Result<ConfirmEmailResponseModel>> confirmEmail(
    ConfirmEmailRequestBody confirmEmailRequestBody,
  ) {
    return executeApiCall<ConfirmEmailResponseModel>(() async {
      final response = await _apiManager.confirmEmail(confirmEmailRequestBody);
      return response;
    });
  }
}
