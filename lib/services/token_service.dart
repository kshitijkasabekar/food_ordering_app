import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenService {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  static const String _accessKey = 'access_token';
  static const String _refreshKey = 'refresh_token';

  /// Save tokens securely
  Future<void> saveTokens({
    required String access,
    required String refresh,
  }) async {
    await _storage.write(key: _accessKey, value: access);
    await _storage.write(key: _refreshKey, value: refresh);
  }

  /// Get access token
  Future<String?> getAccessToken() async {
    return await _storage.read(key: _accessKey);
  }

  /// Get refresh token
  Future<String?> getRefreshToken() async {
    return await _storage.read(key: _refreshKey);
  }

  /// Clear tokens (logout)
  Future<void> clearTokens() async {
    await _storage.delete(key: _accessKey);
    await _storage.delete(key: _refreshKey);
  }
}