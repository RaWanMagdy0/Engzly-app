import 'dart:async';
import 'package:dio/dio.dart';
import 'package:engzly/core/helper/local/token_manger.dart';
import 'package:engzly/core/networking/api/api_constants.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

@injectable
class DioFactory {
  Duration get _timeout => const Duration(seconds: 60);

  bool _isRefreshing = false;
  final List<void Function(String?)> _onTokenRefreshed = [];

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
          debugPrint(" Request with token");
        }
        return handler.next(options);
      },
      onError: (DioException error, handler) async {
        if (error.response?.statusCode == 401) {
          debugPrint(" 401 Unauthorized - Token expired or invalid");

          if (_isRefreshing) {
            debugPrint(" Already refreshing, waiting...");
            await _waitForTokenRefresh(error, handler);
            return;
          }

          _isRefreshing = true;

          try {
            final newToken = await _refreshToken(dio);

            if (newToken != null && newToken.isNotEmpty) {
              debugPrint(" Got new token, retrying request");
              await TokenManager.setToken(token: newToken);

              _notifyTokenRefreshed(newToken);

              final retryRequest = error.requestOptions;
              retryRequest.headers["Authorization"] = "Bearer $newToken";

              final cloneResponse = await dio.fetch(retryRequest);
              debugPrint(" Retry success");
              return handler.resolve(cloneResponse);
            } else {
              debugPrint(" Refresh failed - clearing tokens");
              await TokenManager.deleteToken();
              await TokenManager.deleteRefreshToken();
              _notifyTokenRefreshed(null);
              return handler.reject(error);
            }
          } catch (e) {
            debugPrint(" Exception during refresh: $e");
            await TokenManager.deleteToken();
            await TokenManager.deleteRefreshToken();
            _notifyTokenRefreshed(null);
            return handler.reject(error);
          } finally {
            _isRefreshing = false;
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

  Future<void> _waitForTokenRefresh(
      DioException error, ErrorInterceptorHandler handler) async {
    final completer = Completer<String?>();

    _onTokenRefreshed.add((token) {
      if (!completer.isCompleted) {
        completer.complete(token);
      }
    });

    final newToken = await completer.future;

    if (newToken != null && newToken.isNotEmpty) {
      try {
        final retryRequest = error.requestOptions;
        retryRequest.headers["Authorization"] = "Bearer $newToken";

        final response = await Dio(
          BaseOptions(
            baseUrl: ApiConstants.baseUrl,
            connectTimeout: _timeout,
            receiveTimeout: _timeout,
          ),
        ).fetch(retryRequest);

        return handler.resolve(response);
      } catch (e) {
        return handler.reject(error);
      }
    } else {
      return handler.reject(error);
    }
  }

  void _notifyTokenRefreshed(String? token) {
    for (var callback in _onTokenRefreshed) {
      callback(token);
    }
    _onTokenRefreshed.clear();
  }

  Future<String?> _refreshToken(Dio dio) async {
    try {
      final access = await TokenManager.getToken();
      final refresh = await TokenManager.getRefreshToken();

      if (refresh == null || refresh.isEmpty) {
        debugPrint(" No refresh token available");
        return null;
      }

      debugPrint(" Calling refresh endpoint...");

      final refreshDio = Dio(
        BaseOptions(
          baseUrl: ApiConstants.baseUrl,
          connectTimeout: _timeout,
          receiveTimeout: _timeout,
        ),
      );

      final response = await refreshDio.post(
        ApiConstants.refreshToken,
        options: Options(
          headers: {'Content-Type': 'application/json'},
          validateStatus: (status) => status == 200,
        ),
        data: {
          "accessToken": access ?? '',
          "refreshToken": refresh,
        },
      );

      final newAccessToken = response.data?["accessToken"] ??
          response.data?["token"] ??
          response.data?["access_token"];
      final newRefreshToken =
          response.data?["refreshToken"] ?? response.data?["refresh_token"];

      if (newAccessToken == null || newAccessToken.isEmpty) {
        debugPrint(" No accessToken in refresh response");
        debugPrint(" Response data: ${response.data}");
        return null;
      }

      if (newRefreshToken != null && newRefreshToken.isNotEmpty) {
        await TokenManager.setRefreshToken(token: newRefreshToken);
        debugPrint(" Both tokens updated");
      }

      return newAccessToken;
    } catch (e) {
      debugPrint(" Refresh token failed: $e");
      return null;
    }
  }

  Future<void> revokeToken(Dio dio) async {
    try {
      final refresh = await TokenManager.getRefreshToken();
      if (refresh == null || refresh.isEmpty) return;

      debugPrint(" Revoking token...");

      await dio.post(
        ApiConstants.revokeToken,
        data: {"refreshToken": refresh},
      );

      await TokenManager.deleteToken();
      await TokenManager.deleteRefreshToken();
      debugPrint(" Token revoked successfully");
    } catch (e) {
      debugPrint(" Token revoke failed: $e");
      await TokenManager.deleteToken();
      await TokenManager.deleteRefreshToken();
    }
  }
}
