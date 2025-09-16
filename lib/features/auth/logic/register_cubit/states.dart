abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterSuccess extends RegisterState {
  final String message;
  RegisterSuccess(this.message);
}

class RegisterError extends RegisterState {
  final String error;
  RegisterError(this.error);
}

class ConfirmEmailSuccess extends RegisterState {
  final String message;
  ConfirmEmailSuccess(this.message);
}

class ConfirmEmailError extends RegisterState {
  final String error;
  ConfirmEmailError(this.error);
}

class ResendLoadingState extends RegisterState {
  String? loadingMessage;
  ResendLoadingState({required this.loadingMessage});
}

class ResendSuccessState extends RegisterState {
  final String? success;
  ResendSuccessState({required this.success});
}

class ResendErrorState extends RegisterState {
  final String? errorMassage;
  ResendErrorState({required this.errorMassage});
}
