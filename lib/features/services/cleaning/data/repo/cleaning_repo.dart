import 'package:engzly/core/helper/local/token_manger.dart';
import 'package:engzly/core/networking/api/api_result.dart';
import 'package:engzly/core/networking/api/execute_api_call.dart';
import 'package:engzly/features/services/cleaning/data/api_manager/cleaning_api_manager.dart';
import 'package:engzly/features/services/cleaning/data/models/cleaning_booking_request_model.dart';
import 'package:engzly/features/services/cleaning/data/models/cleaning_booking_response.dart';
import 'package:injectable/injectable.dart';

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
  
  Future<String> _getToken() async {
    final token = await TokenManager.getToken();
    if (token == null || token.isEmpty) {
      throw Exception("Token is missing. Please login again.");
    }
    return 'Bearer $token';
  }
}
