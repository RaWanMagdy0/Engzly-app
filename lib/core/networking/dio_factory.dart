// import 'dart:developer';

// import 'package:dio/dio.dart';
// import 'package:flutter/cupertino.dart';
// import 'api_constants.dart';

// class DioFactory {
//   DioFactory._();

//   static Dio? _dio;

//   static Dio getDio() {
//     if (_dio == null) {
//       log("🛠️ Initializing Dio");
//       _dio = Dio(
//         BaseOptions(
//           baseUrl: ApiConstants.baseUrl,
//           connectTimeout: const Duration(seconds: 30),
//           receiveTimeout: const Duration(seconds: 30),
//           headers: {
//             'Content-Type': 'application/json',
//             'Accept': 'application/json',
//           },
//         ),
//       );
//       _addInterceptors();
//     }
//     return _dio!;
//   }

//   static void setTokenIntoHeaderAfterLogin(String accessToken) {
//     if (_dio != null) {
//       _dio!.options.headers["Authorization"] = "Bearer $accessToken";
//       log("✅ Authorization header updated after login: Bearer $accessToken");
//     }
//   }

//   static void _addInterceptors() {
//     _dio?.interceptors.addAll([
//       PrettyDioLogger(
//         requestHeader: true,
//         requestBody: true,
//         responseBody: true,
//         error: true,
//         compact: true,
//         maxWidth: 100,
//       ),
//       InterceptorsWrapper(
//         onRequest: (options, handler) async {
//           try {
//             final token = await SharePrefHelper.getString(
//               SharedPrefKeys.userToken,
//             );
//             log("🔑 Attaching token to request: $token");
//             if (token != null && token.isNotEmpty) {
//               options.headers['Authorization'] = 'Bearer $token';
//             }
//           } catch (e) {
//             log("⚠️ Failed to attach token: $e");
//           }
//           return handler.next(options);
//         },
//         onError: (DioException error, handler) async {
//           final requestOptions = error.requestOptions;

//           log(
//             "❗ Request failed → ${requestOptions.method} ${requestOptions.uri}",
//           );
//           log("❗ Error StatusCode: ${error.response?.statusCode}");
//           log("❗ Error Message: ${error.message}");

//           if (error.response?.statusCode == 401 && !_isRetry(requestOptions)) {
//             log("🔁 Access token expired. Trying to refresh...");

//             final refreshToken = await SharePrefHelper.getString(
//               SharedPrefKeys.refreshToken,
//             );
//             log("🔄 Refresh Token: $refreshToken");

//             if (refreshToken == null || refreshToken.isEmpty) {
//               log("🚫 No refresh token found. Redirecting to login...");
//               await SharePrefHelper.clearAllData();
//               return handler.reject(error);
//             }

//             try {
//               final apiService = ApiService(_dio!);
//               final newToken = await apiService.refreshAccessToken(
//                 RefreshTokenRequestBody(refreshToken: refreshToken),
//               );
//               debugPrint('tokenadfafa ' + newToken.accessToken.toString());

//               if ((newToken.accessToken?.isNotEmpty ?? false)) {
//                 log("✅ New Access Token: ${newToken.accessToken}");
//                 await SharePrefHelper.setData(
//                   SharedPrefKeys.userToken,
//                   newToken.accessToken!,
//                 );

//                 // ✅ تحديث الـ refresh token لو السيرفر رجعه جديد
//                 if ((newToken.refreshToken?.isNotEmpty ?? false)) {
//                   await SharePrefHelper.setData(
//                     SharedPrefKeys.refreshToken,
//                     newToken.refreshToken!,
//                   );
//                   log("🔁 New Refresh Token saved: ${newToken.refreshToken}");
//                 } else {
//                   log("⚠️ No new refresh token received, keeping the old one.");
//                 }

//                 // تحديث الهيدر في Dio
//                 DioFactory.setTokenIntoHeaderAfterLogin(newToken.accessToken!);

//                 requestOptions.extra['retry'] = true;

//                 final clonedRequest = await _dio!.request(
//                   requestOptions.path,
//                   data: requestOptions.data,
//                   queryParameters: requestOptions.queryParameters,
//                   options: Options(
//                     method: requestOptions.method,
//                     headers: {
//                       'Authorization': 'Bearer ${newToken.accessToken}',
//                       'Content-Type': 'application/json',
//                       'Accept': 'application/json',
//                     },
//                   ),
//                 );

//                 return handler.resolve(clonedRequest);
//               } else {
//                 log("❌ Token refresh returned empty token. Logging out.");
//                 await SharePrefHelper.clearAllData();
//                 return handler.reject(error);
//               }
//             } catch (e, stackTrace) {
//               log("❌ Refresh failed: $e", stackTrace: stackTrace);
//               await SharePrefHelper.clearAllData();
//               return handler.reject(error);
//             }
//           } else {
//             log("⚠️ Non-401 error or already retried.");
//             return handler.next(error);
//           }
//         },
//       ),
//     ]);
//   }

//   static bool _isRetry(RequestOptions options) {
//     return options.extra["retry"] == true;
//   }
// }
