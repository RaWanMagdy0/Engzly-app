import 'package:engzly/core/networking/api_error_handler.dart';
import 'package:engzly/core/networking/api_error_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BaseViewModel<T> extends Cubit<T> {
  BaseViewModel(super.initialState);

  ApiErrorModel getErrorModelFromException(dynamic exception) {
    return ApiErrorHandler.handle(exception ?? Exception());
  }

  String getErrorMessageFromException(dynamic exception) {
    final errorModel = getErrorModelFromException(exception);
    return errorModel.message ?? "An unknown error occurred. Please try again";
  }
}
