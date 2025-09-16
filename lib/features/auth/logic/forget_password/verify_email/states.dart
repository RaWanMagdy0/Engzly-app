abstract class VerifyEmailState {}

class VerifyEmailInitial extends VerifyEmailState {}

class VerifyEmailLoading extends VerifyEmailState {}

class VerifyEmailSuccess extends VerifyEmailState {
  final String message;
  VerifyEmailSuccess(this.message);
}

class VerifyEmailError extends VerifyEmailState {
  final String error;
  VerifyEmailError(this.error);
}

class ResendLoadingState extends VerifyEmailState {
  String? loadingMessage;
  ResendLoadingState({required this.loadingMessage});
}

class ResendSuccessState extends VerifyEmailState {
  final String? success;
  ResendSuccessState({required this.success});
}

class ResendErrorState extends VerifyEmailState {
  final String? success;
  ResendErrorState({required this.success});
}
