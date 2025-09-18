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
        debugPrint(
            "➡️ Request with token: Bearer $token"); // ⬅️ هتشوف التوكن اللي طالع
        if (token != null && token.isNotEmpty) {
          options.headers["Authorization"] = "Bearer $token";
        }
        return handler.next(options);
      },
      onError: (DioException error, handler) async {
        if (error.response?.statusCode == 401) {
          debugPrint(
              "🔑 401 Unauthorized detected, trying to refresh token...");

          try {
            final newToken = await _refreshToken(dio);

            if (newToken != null && newToken.isNotEmpty) {
              debugPrint("✅ Got new token: $newToken");
              await TokenManager.setToken(token: newToken);

              final retryRequest = error.requestOptions;
              retryRequest.headers["Authorization"] = "Bearer $newToken";

              debugPrint("🔄 Retrying request with new token...");
              final cloneResponse = await dio.fetch(retryRequest);

              debugPrint(
                  "🎉 Retry success, status: ${cloneResponse.statusCode}");
              return handler.resolve(cloneResponse);
            } else {
              debugPrint("❌ Failed to refresh token, logging out...");
              await TokenManager.deleteToken();
            }
          } catch (e) {
            debugPrint("💥 Exception while refreshing token: $e");
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
      final access = await TokenManager.getToken();
      final refresh = await TokenManager.getRefreshToken();

      if (refresh == null ||
          refresh.isEmpty ||
          access == null ||
          access.isEmpty) {
        return null;
      }

      final response = await dio.post(
        ApiConstants.refreshToken,
        data: {
          "accessToken": access,
          "refreshToken": refresh,
        },
      );

      final newAccessToken = response.data?["accessToken"];
      final newRefreshToken = response.data?["refreshToken"];

      if (newAccessToken == null) {
        debugPrint("⚠️ refresh response missing accessToken: ${response.data}");
        return null;
      }

      if (newRefreshToken != null) {
        await TokenManager.setRefreshToken(token: newRefreshToken);
      }

      debugPrint("✅ token refreshed");
      return newAccessToken;
    } catch (e) {
      debugPrint("❌ refresh token failed: $e");
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
