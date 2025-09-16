import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart';
import 'package:engzly/core/helper/local/token_manger.dart';
import 'package:engzly/core/networking/api/api_result.dart';
import 'package:engzly/core/networking/api/execute_api_call.dart';
import 'package:engzly/features/profile/data/models/update_user_data_models/update_user_data_request_body.dart';
import 'package:engzly/features/profile/data/profile_api/profile_api_manager.dart';
import 'package:injectable/injectable.dart';

@injectable
class UpdateUserDataRepo {
  final ProfileApiManager _profileApiManager;

  UpdateUserDataRepo(this._profileApiManager);

  Future<Result<String>> updateUserData(
    UpdateUserDataRequestBody body,
  ) {
    return executeApiCall<String>(() async {
      var token = await _getToken();

      /// FormData build
      final formData = FormData.fromMap({
        "CuurentAddress": body.cuurentAddress,
        "PhoneNumber": body.phoneNumber,
        "FullName": body.fullName,
        if (body.image != null)
          "Image": await MultipartFile.fromFile(
            body.image!.path,
            filename: basename(body.image!.path),
            contentType: MediaType("image", "jpeg"),
          ),
      });

      final response = await _profileApiManager.updateUserData(token, formData);
      return response;
    });
  }

  Future<String> _getToken() async {
    var token = await TokenManager.getToken();
    if (token == null || token.isEmpty) {
      throw Exception("Token is missing. Please login again.");
    }
    return 'Bearer $token';
  }
}
