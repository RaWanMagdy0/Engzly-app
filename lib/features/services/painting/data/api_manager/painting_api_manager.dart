import 'package:dio/dio.dart';
import 'package:engzly/core/networking/api/api_constants.dart';
import 'package:engzly/features/services/painting/data/models/painting_booking_request_model.dart';
import 'package:engzly/features/services/painting/data/models/painting_booking_response.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
part 'painting_api_manager.g.dart';

@lazySingleton
@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class PaintingApiManager {
  @factoryMethod
  factory PaintingApiManager(Dio dio) = _PaintingApiManager;

  @POST(ApiConstants.paintingCheckOut)
  Future<PaintingBookingResponse> checkOut(
    @Header("Authorization") String token,
    @Body() PaintingBookingRequestModel bookingRequestModel,
  );

 
}
