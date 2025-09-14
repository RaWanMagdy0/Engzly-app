import 'package:dio/dio.dart';
import 'package:engzly/core/helper/local/token_manger.dart';
import 'package:engzly/core/networking/api/api_constants.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

@injectable
class DioFactory {
  Duration get _timeout => const Duration(seconds: 60);

  Dio createDio() {
    Dio dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: _timeout,
        receiveTimeout: _timeout,
        headers: {"Cache-Control": "no-cache", "Pragma": "no-cache"},
        validateStatus: (status) =>
            status != null ? status == 200 || status == 201 : false,
      ),
    );

    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await TokenManager.getToken();
        if (token != null && token.isNotEmpty) {
          options.headers["Authorization"] = "Bearer $token";
        }
        return handler.next(options);
      },
      onError: (DioException error, handler) async {
        if (error.response?.statusCode == 401) {
          try {
            final newToken = await _refreshToken(dio);

            if (newToken != null && newToken.isNotEmpty) {
              await TokenManager.setToken(token: newToken);

              final retryRequest = error.requestOptions;
              retryRequest.headers["Authorization"] = "Bearer $newToken";

              final cloneResponse = await dio.fetch(retryRequest);
              return handler.resolve(cloneResponse);
            }
          } catch (e) {
            await TokenManager.deleteToken();
          }
        }
        return handler.next(error);
      },
    ));

    if (!kReleaseMode) {
      dio.interceptors.add(
        PrettyDioLogger(
          requestBody: true,
          requestHeader: true,
          responseHeader: true,
        ),
      );
    }

    return dio;
  }

  Future<String?> _refreshToken(Dio dio) async {
    try {
      final refresh = await TokenManager.getRefreshToken();
      if (refresh == null || refresh.isEmpty) return null;

      final response = await dio.post(
        ApiConstants.refreshToken,
        data: {
          "refreshToken": refresh,
        },
      );

      final newAccessToken = response.data["accessToken"];
      final newRefreshToken = response.data["refreshToken"];

      if (newRefreshToken != null) {
        await TokenManager.setRefreshToken(token: newRefreshToken);
      }

      return newAccessToken;
    } catch (e) {
      return null;
    }
  }

  Future<void> revokeToken(Dio dio) async {
    try {
      final refresh = await TokenManager.getRefreshToken();
      if (refresh == null || refresh.isEmpty) return;

      await dio.post(
        ApiConstants.revokeToken,
        data: {
          "refreshToken": refresh,
        },
      );

      await TokenManager.deleteToken();
      await TokenManager.setRefreshToken(token: "");
    } catch (e) {
      await TokenManager.deleteToken();
      await TokenManager.setRefreshToken(token: "");
    }
  }
}
