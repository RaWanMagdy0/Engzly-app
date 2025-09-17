import 'dart:io';
import 'package:dio/dio.dart';
import 'api_error_model.dart';

class ApiErrorHandler {
  static ApiErrorModel handle(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionError:
          return ApiErrorModel(message: "Connection to server failed");
        case DioExceptionType.cancel:
          return ApiErrorModel(message: "Request to the server was cancelled");
        case DioExceptionType.connectionTimeout:
          return ApiErrorModel(message: "Connection timeout with the server");
        case DioExceptionType.receiveTimeout:
          return ApiErrorModel(
            message: "Receive timeout in connection with the server",
          );
        case DioExceptionType.sendTimeout:
          return ApiErrorModel(
            message: "Send timeout in connection with the server",
          );
        case DioExceptionType.badResponse:
          final statusCode = error.response?.statusCode;
          return _handleError(error.response?.data, statusCode: statusCode);
        case DioExceptionType.unknown:
          if (error.error is SocketException) {
            return ApiErrorModel(message: "No Internet connection");
          }
          return ApiErrorModel(message: "Unexpected error occurred");
        default:
          return ApiErrorModel(message: "Something went wrong");
      }
    } else {
      return ApiErrorModel(message: "Unknown error occurred");
    }
  }
}

ApiErrorModel _handleError(dynamic data, {int? statusCode}) {
  if (data is Map<String, dynamic>) {
    final message = data["message"] ??
        data["error"] ??
        data["errors"]?.toString() ??
        "Unknown error occurred";
    return ApiErrorModel(
      code: statusCode ?? -1,
      message: message,
    );
  } else if (data is String) {
    return ApiErrorModel(
      code: statusCode ?? -1,
      message: data,
    );
  }
  return ApiErrorModel(
    code: statusCode ?? -1,
    message: "Unknown error occurred",
  );
}
