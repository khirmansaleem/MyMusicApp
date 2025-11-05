// local storage for storing the token from the
// to maintain the login state persistence,
// it is shared_preference local storage here
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_local_repository.g.dart';

@Riverpod(keepAlive: true)
Future<AuthLocalRepository> authLocalRepository(Ref ref) async =>
    AuthLocalRepository.create();

class AuthLocalRepository {
  final SharedPreferences _sharedPreferences;

  AuthLocalRepository._(this._sharedPreferences);

  // ✅ Add this public factory constructor
  factory AuthLocalRepository.fromPrefs(SharedPreferences prefs) {
    return AuthLocalRepository._(prefs);
  }

  static Future<AuthLocalRepository> create() async {
    final prefs = await SharedPreferences.getInstance();
    return AuthLocalRepository._(prefs);
  }

  Future<void> setToken(String? token) async {
    if (token != null) {
      await _sharedPreferences.setString('x-auth-token', token);
      debugPrint('💾 [AuthDebug] Token stored persistently: $token');
    }
  }

  String? getToken() {
    return _sharedPreferences.getString('x-auth-token');
  }

  void clearToken() {
    _sharedPreferences.remove('x-auth-token');
  }
}
