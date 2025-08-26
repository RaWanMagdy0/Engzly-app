import 'package:dio/dio.dart';
import 'package:engzly/core/networking/api/dio/api_constants.dart';
import 'package:engzly/features/auth/data/models/confirm_email/confirm_email_request_body.dart';
import 'package:engzly/features/auth/data/models/confirm_email/confirm_email_response_model.dart';
import 'package:engzly/features/auth/data/models/login/login_response_model.dart';
import 'package:engzly/features/auth/data/models/signup/register_request_body.dart';
import 'package:engzly/features/auth/data/models/signup/register_response_model.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
part 'auth_api_manager.g.dart';

@lazySingleton
@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class AuthApiManager {
  @factoryMethod
  factory AuthApiManager(Dio dio) = _AuthApiManager;

  @FormUrlEncoded()
  @POST(ApiConstants.login)
  Future<LoginResponseModel> login(
    @Field("Email") String email,
    @Field("Password") String password,
  );

  @POST(ApiConstants.register)
  Future<RegisterResponseModel> register(
    @Body() RegisterRequestBody signupRequestModel,
  );

  @POST(ApiConstants.confirmEmail)
  Future<ConfirmEmailResponseModel> confirmEmail(
    @Body() ConfirmEmailRequestBody confirmEmailRequestBody,
  );
}
