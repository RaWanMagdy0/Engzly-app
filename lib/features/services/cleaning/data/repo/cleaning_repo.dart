import 'package:engzly/core/helper/local/token_manger.dart';
import 'package:engzly/features/services/cleaning/data/api_manager/cleaning_api_manager.dart';
import 'package:injectable/injectable.dart';

@injectable
class CleaningRepo {
  final CleaningApiManager _apiManager;

  CleaningRepo(this._apiManager);

  
  Future<String> _getToken() async {
    final token = await TokenManager.getToken();
    if (token == null || token.isEmpty) {
      throw Exception("Token is missing. Please login again.");
    }
    return 'Bearer $token';
  }
}
