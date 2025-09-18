import 'package:engzly/core/helper/local/token_manger.dart';
import 'package:engzly/core/networking/api/api_result.dart';
import 'package:engzly/core/networking/api/execute_api_call.dart';
import 'package:engzly/features/home/data/home_api/home_api_manger.dart';
import 'package:engzly/features/home/data/models/offers/offers_response_model.dart';
import 'package:engzly/features/home/data/models/service/service_response_model.dart';
import 'package:injectable/injectable.dart';

@injectable
class HomeRepo {
  final HomeApiManager _homeApiManager;

  HomeRepo(this._homeApiManager);

  Future<Result<List<OffersResponseModel>>> getOffers() {
    return executeApiCall<List<OffersResponseModel>>(() async {
      final token = await _getToken();
      final response = await _homeApiManager.getOffers(token);
      return response;
    });
  }

  Future<Result<List<ServiceResponseModel>>> getservice() async {
    return executeApiCall<List<ServiceResponseModel>>(() async {
      final token = await _getToken();
      final response = await _homeApiManager.getservice(token);
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
