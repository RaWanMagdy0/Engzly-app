import 'package:engzly/core/helper/local/token_manger.dart';
import 'package:engzly/core/networking/api/api_result.dart';
import 'package:engzly/core/networking/api/execute_api_call.dart';
import 'package:engzly/features/profile/data/models/get_address/location_model.dart';
import 'package:engzly/features/profile/data/profile_api/profile_api_manager.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetLocationsRepo {
  final ProfileApiManager _profileApiManager;

  GetLocationsRepo(this._profileApiManager);

  Future<Result<List<LocationModel>>> getLocations() {
    return executeApiCall<List<LocationModel>>(() async {
      final token = await _getToken();
      final response = await _profileApiManager.getLocations(token);
      return response;
    });
  }

  Future<String> _getToken() async {
    final token = await TokenManager.getToken();
    if (token == null || token.isEmpty) {
      throw Exception("Token is missing. Please login again.");
    }
    return 'Bearer $token';
  }
}
