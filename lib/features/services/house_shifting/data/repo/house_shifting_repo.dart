import 'package:engzly/core/helper/local/token_manger.dart';
import 'package:engzly/core/networking/api/api_result.dart';
import 'package:engzly/core/networking/api/execute_api_call.dart';
import 'package:engzly/features/services/house_shifting/data/api_manager/house_shifting_api.dart';
import 'package:engzly/features/services/house_shifting/data/models/booking/house_booking_request_model.dart';
import 'package:engzly/features/services/house_shifting/data/models/booking/house_booking_response.dart';
import 'package:engzly/features/services/house_shifting/data/models/furniture_model.dart';
import 'package:engzly/features/services/house_shifting/data/models/house_size_model.dart';
import 'package:engzly/features/services/house_shifting/data/models/promo_code_response.dart';
import 'package:engzly/features/services/house_shifting/data/models/vehicle_model.dart';
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
   Future<Result<List<VehicleModel>>> getVehicles() {
    return executeApiCall<List<VehicleModel>>(() async {
      final token = await _getToken();
      final response = await _apiManager.getVehicles(token);
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
 Future<Result<HouseBookingResponse>> checkOut(HouseBookingRequestModel bookingRequestModel) {
  return executeApiCall<HouseBookingResponse>(() async {
    final token = await _getToken();
    final response = await _apiManager.checkOut(token, bookingRequestModel);

    final message = response ;

    return message;
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
