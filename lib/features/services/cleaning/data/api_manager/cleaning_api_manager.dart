import 'package:dio/dio.dart';

import 'package:engzly/core/networking/api/api_constants.dart';
import 'package:engzly/features/services/cleaning/data/models/cleaning_booking_request_model.dart';
import 'package:engzly/features/services/cleaning/data/models/cleaning_booking_response.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
part 'cleaning_api_manager.g.dart';

@lazySingleton
@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class CleaningApiManager {
  @factoryMethod
  factory CleaningApiManager(Dio dio) = _CleaningApiManager;

  @POST(ApiConstants.cleaningCheckOut)
  Future<CleaningBookingResponse> checkOut(
    @Header("Authorization") String token,
    @Body() CleaningBookingRequestModel bookingRequestModel,
  );

 
}
