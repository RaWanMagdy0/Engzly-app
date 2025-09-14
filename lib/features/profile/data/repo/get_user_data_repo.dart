import 'package:engzly/core/helper/local/token_manger.dart';
import 'package:engzly/core/networking/api/api_result.dart';
import 'package:engzly/core/networking/api/execute_api_call.dart';
import 'package:engzly/features/profile/data/models/main_profile_models/get_user_data_response_model.dart';
import 'package:engzly/features/profile/data/profile_api/profile_api_manager.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetUserDataRepo {
  final ProfileApiManager _profileApiManager;

  GetUserDataRepo(this._profileApiManager);

Future<Result<GetUserDataResponseModel>> getUserData() {
  return executeApiCall<GetUserDataResponseModel>(() async {
    var token = await _getToken();
      final response = await _profileApiManager.getUserData(token);
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
