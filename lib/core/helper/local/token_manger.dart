import 'secure_storage.dart';

class TokenManager {
  static const String tokenKey = "token";
  static const String refreshKey = "refreshToken";

  static Future<void> setToken({required String? token}) async {
    return await SecureStorageFactory.writeData(
        key: tokenKey, value: token ?? "");
  }

  static Future<String?> getToken() async {
    return await SecureStorageFactory.readData(key: tokenKey);
  }

  static Future<void> deleteToken() async {
    return await SecureStorageFactory.deleteData(key: tokenKey);
  }

  static Future<void> setRefreshToken({required String? token}) async {
    return await SecureStorageFactory.writeData(
        key: refreshKey, value: token ?? "");
  }

  static Future<String?> getRefreshToken() async {
    return await SecureStorageFactory.readData(key: refreshKey);
  }

  static Future<void> deleteRefreshToken() async {
    return await SecureStorageFactory.deleteData(key: refreshKey);
  }

  static Future<void> clearAll() async {
    await deleteToken();
    await deleteRefreshToken();
  }
}
