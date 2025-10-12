import 'package:dio/dio.dart';
import 'package:engzly/core/networking/api/api_constants.dart';
import 'package:engzly/features/services/house_shifting/data/models/booking/house_booking_request_model.dart';
import 'package:engzly/features/services/house_shifting/data/models/booking/house_booking_response.dart';
import 'package:engzly/features/services/house_shifting/data/models/furniture_model.dart';
import 'package:engzly/features/services/house_shifting/data/models/house_size_model.dart';
import 'package:engzly/features/services/house_shifting/data/models/promo_code_response.dart';
import 'package:engzly/features/services/house_shifting/data/models/vehicle_model.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
part 'house_shifting_api.g.dart';

@lazySingleton
@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class HouseShiftingApiManager {
  @factoryMethod
  factory HouseShiftingApiManager(Dio dio) = _HouseShiftingApiManager;

  @GET(ApiConstants.getHouseSize)
  Future<List<HouseSizeModel>> getHouseSize(
      @Header("Authorization") String token);
  @GET(ApiConstants.getFurnitures)
  Future<List<FurnitureModel>> getFurnitures(
      @Header("Authorization") String token);
  @GET(ApiConstants.getVehicles)
  Future<List<VehicleModel>> getVehicles(@Header("Authorization") String token);
  @GET(ApiConstants.checkPromoCode)
  Future<PromoCodeResponse> checkPromoCode(
    @Header("Authorization") String token,
    @Query("code") String code,
  );

  @POST(ApiConstants.houseShiftingCheckOut)
  Future<HouseBookingResponse> checkOut(
    @Header("Authorization") String token,
    @Body() HouseBookingRequestModel bookingRequestModel,
  );
}
