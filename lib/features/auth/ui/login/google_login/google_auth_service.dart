import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';

@injectable
class AuthService {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email', 'profile'],
  );
  final FirebaseAuth _auth = FirebaseAuth.instance;
  
  GoogleSignInAuthentication? _cachedGoogleAuth;

  Future<User?> signInWithGoogle() async {
    try {
      print("🔵 Step 1: Google Sign In...");
      
      final GoogleSignInAccount? googleAccount = await _googleSignIn.signIn();
      
      if (googleAccount == null) {
        print("❌ User cancelled Google Sign In");
        return null;
      }

      print("🔵 Step 2: Getting Google Auth...");
      
      final GoogleSignInAuthentication googleAuth = 
          await googleAccount.authentication;
      
      _cachedGoogleAuth = googleAuth;
      
      print("✅ Google ID Token available: ${googleAuth.idToken != null}");
      print("✅ Google Access Token available: ${googleAuth.accessToken != null}");
      
      if (googleAuth.idToken != null) {
        print("🔑 Google ID Token (First 50): ${googleAuth.idToken!.substring(0, 50)}...");
      }

      print("🔵 Step 3: Firebase Sign In...");

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await _auth.signInWithCredential(credential);
      print("✅ Firebase Sign In Success");
      return userCredential.user;
    } catch (e) {
      print("❌ Error signing in with Google: $e");
      return null;
    }
  }
  
  Future<Map<String, String?>> getGoogleTokens() async {
    try {
      if (_cachedGoogleAuth != null) {
        print("✅ Using cached Google Auth");
        return {
          'idToken': _cachedGoogleAuth!.idToken,
          'accessToken': _cachedGoogleAuth!.accessToken,
        };
      }
      
      final GoogleSignInAccount? account = _googleSignIn.currentUser;
      
      if (account == null) {
        print("❌ No current Google user");
        return {'idToken': null, 'accessToken': null};
      }
      
      final GoogleSignInAuthentication auth = await account.authentication;
      _cachedGoogleAuth = auth;
      
      print("✅ Got Google Tokens from current user");
      
      return {
        'idToken': auth.idToken,
        'accessToken': auth.accessToken,
      };
    } catch (e) {
      print("❌ Error getting Google tokens: $e");
      return {'idToken': null, 'accessToken': null};
    }
  }
  
  Future<String?> getGoogleIdToken() async {
    final tokens = await getGoogleTokens();
    return tokens['idToken'];
  }
  
  Future<String?> getGoogleAccessToken() async {
    final tokens = await getGoogleTokens();
    return tokens['accessToken'];
  }
}