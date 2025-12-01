import 'package:engzly/core/helper/local/token_manger.dart';
import 'package:engzly/core/networking/api/api_result.dart';
import 'package:engzly/core/networking/api/execute_api_call.dart';
import 'package:engzly/features/services/cleaning/data/api_manager/cleaning_api_manager.dart';
import 'package:engzly/features/services/cleaning/data/models/request/cleaning_booking_request_model.dart';
import 'package:engzly/features/services/cleaning/data/models/response/cleaning_response_model.dart/cleaning_booking_response.dart';
import 'package:engzly/features/services/cleaning/data/models/response/location_response/location_model.dart';
import 'package:injectable/injectable.dart';
import 'package:engzly/features/services/cleaning/data/models/response/house_size_model.dart/house_size_model.dart';
import 'package:engzly/features/services/cleaning/data/models/response/promo_code.dart/promo_code_response.dart';


@injectable
class CleaningRepo {
  final CleaningApiManager _apiManager;

  CleaningRepo(this._apiManager);
Future<Result<CleaningBookingResponse>> checkOut(CleaningBookingRequestModel bookingRequestModel) {
  return executeApiCall<CleaningBookingResponse>(() async {
    final token = await _getToken();
    final response = await _apiManager.checkOut(token, bookingRequestModel);

    final message = response ;

    return message;
  });
}
  Future<Result<List<HouseSizeModel>>> getHouseSize() {
    return executeApiCall<List<HouseSizeModel>>(() async {
      final token = await _getToken();
      final response = await _apiManager.getHouseSize(token);
      return response;
    });
  }
  Future<Result<PromoCodeResponse>> checkPromoCode(String code) {
  return executeApiCall<PromoCodeResponse>(() async {
    final token = await _getToken();
    final response = await _apiManager.checkPromoCode(token, code);

    final message = response ;

    return message;
  });
}
 Future<Result<List<LocationModel>>> getLocations() {
    return executeApiCall<List<LocationModel>>(() async {
      final token = await _getToken();
      final response = await _apiManager.getLocations(token);
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
