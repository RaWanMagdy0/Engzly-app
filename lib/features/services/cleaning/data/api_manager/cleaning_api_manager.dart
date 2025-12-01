import 'package:dio/dio.dart';

import 'package:engzly/core/networking/api/api_constants.dart';
import 'package:engzly/features/services/cleaning/data/models/request/cleaning_booking_request_model.dart';
import 'package:engzly/features/services/cleaning/data/models/response/cleaning_response_model.dart/cleaning_booking_response.dart';
import 'package:engzly/features/services/cleaning/data/models/response/house_size_model.dart/house_size_model.dart';
import 'package:engzly/features/services/cleaning/data/models/response/location_response/location_model.dart';
import 'package:engzly/features/services/cleaning/data/models/response/promo_code.dart/promo_code_response.dart';
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
  @GET(ApiConstants.getHouseSize)
  Future<List<HouseSizeModel>> getHouseSize(
      @Header("Authorization") String token);
  @GET(ApiConstants.checkPromoCode)
  Future<PromoCodeResponse> checkPromoCode(
    @Header("Authorization") String token,
    @Query("code") String code,
  );
   @GET(ApiConstants.getLocations)
  Future<List<LocationModel>> getLocations(
    @Header("Authorization") String token,
  );
}
