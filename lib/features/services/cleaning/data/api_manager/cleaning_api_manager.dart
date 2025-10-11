import 'package:dio/dio.dart';

import 'package:engzly/core/networking/api/api_constants.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
part 'cleaning_api_manager.g.dart';

@lazySingleton
@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class CleaningApiManager {
  @factoryMethod
  factory CleaningApiManager(Dio dio) = _CleaningApiManager;

 

 
}
