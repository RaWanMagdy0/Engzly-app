import 'package:engzly/core/helper/local/token_manger.dart';
import 'package:engzly/core/networking/api/api_result.dart';
import 'package:engzly/core/networking/api/execute_api_call.dart';
import 'package:engzly/features/services/house_shifting/data/api_manager/house_shifting_api.dart';
import 'package:engzly/features/services/house_shifting/data/models/furniture_model.dart';
import 'package:engzly/features/services/house_shifting/data/models/house_size_model.dart';
import 'package:injectable/injectable.dart';

@injectable
class HouseShiftingRepo {
  final HouseShiftingApiManager _apiManager;

  HouseShiftingRepo(this._apiManager);

  Future<Result<List<HouseSizeModel>>> getHouseSize() {
    return executeApiCall<List<HouseSizeModel>>(() async {
      final token = await _getToken();
      final response = await _apiManager.getHouseSize(token);
      return response;
    });
  }

  Future<Result<List<FurnitureModel>>> getFurnitures() {
    return executeApiCall<List<FurnitureModel>>(() async {
      final token = await _getToken();
      final response = await _apiManager.getFurnitures(token);
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
