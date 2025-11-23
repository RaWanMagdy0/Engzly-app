abstract class GoogleLoginState {}

class GoogleLoginInitial extends GoogleLoginState {}

class GoogleLoginLoading extends GoogleLoginState {}

class GoogleLoginSuccess extends GoogleLoginState {
  final String message;
  GoogleLoginSuccess(this.message);
}

class GoogleLoginError extends GoogleLoginState {
  final String error;
  GoogleLoginError(this.error);
}

