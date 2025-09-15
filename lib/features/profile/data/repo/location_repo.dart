import 'package:engzly/core/helper/local/token_manger.dart';
import 'package:engzly/core/networking/api/api_result.dart';
import 'package:engzly/core/networking/api/execute_api_call.dart';
import 'package:engzly/features/profile/data/models/address/add_location_request_body.dart';
import 'package:engzly/features/profile/data/models/address/add_location_response_model.dart';
import 'package:engzly/features/profile/data/profile_api/profile_api_manager.dart';
import 'package:injectable/injectable.dart';

@injectable
class LocationRepo {
  final ProfileApiManager _profileApiManager;

  LocationRepo(this._profileApiManager);

  Future<Result<AddLocationResponseModel>> selectLocation(
    AddLocationRequestBody addLocationRequestBody,
  ) {
    return executeApiCall<AddLocationResponseModel>(() async {
      var token = await _getToken();

      final response = await _profileApiManager.selectLocation(
          token, addLocationRequestBody);
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
