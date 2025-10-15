import 'package:engzly/core/helper/local/token_manger.dart';
import 'package:engzly/core/networking/api/api_result.dart';
import 'package:engzly/core/networking/api/execute_api_call.dart';
import 'package:engzly/features/services/vehicle/data/api_manager/vehicle_api_manager.dart';
import 'package:engzly/features/services/vehicle/data/models/vehicle_booking_request_model.dart';
import 'package:engzly/features/services/vehicle/data/models/vehicle_booking_response.dart';
import 'package:injectable/injectable.dart';

@injectable
class VehicleRepo {
  final VehicleApiManager _apiManager;

  VehicleRepo(this._apiManager);
  
Future<Result<VehicleBookingResponse>> vehicleCheckOut(VehicleBookingRequestModel bookingRequestModel) {
  return executeApiCall<VehicleBookingResponse>(() async {
    final token = await _getToken();
    final response = await _apiManager.vehicleCheckOut(token, bookingRequestModel);

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
