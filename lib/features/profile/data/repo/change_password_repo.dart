import 'package:engzly/core/networking/api/api_result.dart';
import 'package:engzly/core/networking/api/execute_api_call.dart';
import 'package:engzly/features/profile/data/models/change_password_models/change_password_request_body.dart';
import 'package:engzly/features/profile/data/models/change_password_models/change_password_response_model.dart';
import 'package:engzly/features/profile/data/profile_api/profile_api_manager.dart';
import 'package:injectable/injectable.dart';

@injectable
class ChangePasswordRepo {
  final ProfileApiManager _profileApiManager;

  ChangePasswordRepo(this._profileApiManager);

  Future<Result<ChangePasswordResponseModel>> changePassword(
    ChangePasswordRequestBody changePasswordRequestBody,
  ) {
    return executeApiCall<ChangePasswordResponseModel>(() async {
      final response =
          await _profileApiManager.changePassword(changePasswordRequestBody);
      return response;
    });
  }
}
