import 'package:dio/dio.dart';
import 'package:engzly/core/networking/api/api_constants.dart';
import 'package:engzly/features/history/data/models/history_response_model.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
part 'history_api_manager.g.dart';

@lazySingleton
@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class HistoryApiManager {
  @factoryMethod
  factory HistoryApiManager(Dio dio) = _HistoryApiManager;

  @GET(ApiConstants.getHistory)
  Future<List<HistoryResponseModel>> getBookings(
    @Header("Authorization") String token,
    @Query("PageNumber") int pageNumber,
    @Query("PageSize") int pageSize,
    @Query("SortDirection") String sortDirection,
  );
}
