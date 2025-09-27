import 'package:engzly/core/helper/local/token_manger.dart';
import 'package:engzly/core/networking/api/api_result.dart';
import 'package:engzly/core/networking/api/execute_api_call.dart';
import 'package:engzly/features/history/data/history_api/history_api_manager.dart';
import 'package:engzly/features/history/data/models/history_response_model.dart';
import 'package:injectable/injectable.dart';

@injectable
class HistoryRepository {
  final HistoryApiManager _apiManager;

  HistoryRepository(this._apiManager);

  Future<Result<List<HistoryResponseModel>>> getUserHistory({
    int pageNumber = 1,
    int pageSize = 10,
    String sortDirection = "desc",
  }) async {
    return executeApiCall<List<HistoryResponseModel>>(() async {
      final token = await _getToken();
      final response = await _apiManager.getBookings(
        token,
        pageNumber,
        pageSize,
        sortDirection,
      );
      return response;
    });
  }

  Future<String> _getToken() async {
    final token = await TokenManager.getToken();
    if (token == null || token.isEmpty) {
      throw Exception("Token is missing. Please login again.");
    }
    return 'Bearer $token';
  }
}
