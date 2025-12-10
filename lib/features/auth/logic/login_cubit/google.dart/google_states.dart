abstract class GoogleLoginState {}

class GoogleLoginInitial extends GoogleLoginState {}

class GoogleLoginLoading extends GoogleLoginState {}

class GoogleLoginSuccess extends GoogleLoginState {
  final String name;
  final String email;
  final String imageUrl;
  
  GoogleLoginSuccess({
    required this.name,
    required this.email,
    required this.imageUrl,
  });
}

class GoogleLoginError extends GoogleLoginState {
  final String message;
  GoogleLoginError(this.message);
}