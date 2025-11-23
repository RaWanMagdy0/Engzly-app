import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';

@injectable
class GoogleAuthService {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email', 'profile'],
    serverClientId:
        '425658170400-3suhj4nc6k8r8u5vbtorl7q16a0qkmff.apps.googleusercontent.com',
  );

  Future<String?> signInWithGoogle() async {
    try {
      await _googleSignIn.signOut();
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) return null;
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      print("🔹 Google ID Token: ${googleAuth.idToken}");
      return googleAuth.idToken;
    } catch (e) {
      print('❌ Google Sign-In Error: $e');
      rethrow;
    }
  }

  Future<void> signOut() => _googleSignIn.signOut();

  GoogleSignInAccount? get currentUser => _googleSignIn.currentUser;
}
