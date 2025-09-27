import 'package:dio/dio.dart';
import 'package:engzly/core/networking/api/api_constants.dart';
import 'package:engzly/features/home/data/models/offers/offers_response_model.dart';
import 'package:engzly/features/home/data/models/service/service_response_model.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
part 'home_api_manger.g.dart';

@lazySingleton
@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class HomeApiManager {
  @factoryMethod
  factory HomeApiManager(Dio dio) = _HomeApiManager;

  @GET(ApiConstants.getOffers)
  Future<List<OffersResponseModel>> getOffers(
    @Header("Authorization") String token,
  );

   @GET(ApiConstants.getservice)
  Future<List<ServiceResponseModel>> getservice(
    @Header("Authorization") String token,
  );

  
}
