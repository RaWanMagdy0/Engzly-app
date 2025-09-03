import 'package:dio/dio.dart';
import 'package:engzly/core/networking/api/api_constants.dart';
import 'package:engzly/features/profile/data/models/change_password_request_body.dart';
import 'package:engzly/features/profile/data/models/change_password_response_model.dart';
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
}
