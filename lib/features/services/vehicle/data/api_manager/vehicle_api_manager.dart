import 'package:dio/dio.dart';

import 'package:engzly/core/networking/api/api_constants.dart';
import 'package:engzly/features/services/vehicle/data/models/vehicle_booking_request_model.dart';
import 'package:engzly/features/services/vehicle/data/models/vehicle_booking_response.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
part 'vehicle_api_manager.g.dart';

@lazySingleton
@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class VehicleApiManager {
  @factoryMethod
  factory VehicleApiManager(Dio dio) = _VehicleApiManager;

 @POST(ApiConstants.vehicleCheckOut)
  Future<VehicleBookingResponse> vehicleCheckOut(
    @Header("Authorization") String token,
    @Body() VehicleBookingRequestModel bookingRequestModel,
  );

 

 
}
