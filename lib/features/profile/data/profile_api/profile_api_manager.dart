import 'package:dio/dio.dart';
//import 'package:http_parser/http_parser.dart';

import 'package:engzly/core/networking/api/api_constants.dart';
import 'package:engzly/features/profile/data/models/address/add_location_request_body.dart';
import 'package:engzly/features/profile/data/models/address/add_location_response_model.dart';
import 'package:engzly/features/profile/data/models/change_password_models/change_password_request_body.dart';
import 'package:engzly/features/profile/data/models/change_password_models/change_password_response_model.dart';
import 'package:engzly/features/profile/data/models/get_address/location_model.dart';
import 'package:engzly/features/profile/data/models/main_profile_models/get_user_data_response_model.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
part 'profile_api_manager.g.dart';

@lazySingleton
@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class ProfileApiManager {
  @factoryMethod
  factory ProfileApiManager(Dio dio) = _ProfileApiManager;

  @PUT(ApiConstants.changePassword)
  Future<ChangePasswordResponseModel> changePassword(
    @Body() ChangePasswordRequestBody changePasswordRequestBody,
  );

  @GET(ApiConstants.getUserData)
  Future<GetUserDataResponseModel> getUserData(
      @Header("Authorization") String token);

  @PUT(ApiConstants.updateUserData)
  Future<String> updateUserData(
    @Header("Authorization") String token,
    @Body() FormData body,
  );

  @POST(ApiConstants.selectLocation)
  Future<AddLocationResponseModel> selectLocation(
    @Header("Authorization") String token,
    @Body() AddLocationRequestBody selectLocationRequestBody,
  );
  @GET(ApiConstants.getLocations)
  Future<List<LocationModel>> getLocations(
    @Header("Authorization") String token,
  );
}
