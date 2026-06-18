import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesUtils {
  late SharedPreferences _prefs;

  SharedPreferencesUtils._();

  static final SharedPreferencesUtils _instance = SharedPreferencesUtils._();

  factory SharedPreferencesUtils() {
    return _instance;
  }

  bool isLoggedIn() {
    return _prefs.getString('token') != null;
  }

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> _initialize() {
    return init();
  }

  Future<void> setToken(String token) async {
    await _initialize();
    _prefs.setString('token', token);
    // ignore: avoid_print
    print(
      "$token =================================================================================",
    );
  }

  String? getToken() {
    if (!_isInitialized()) {
      // ignore: avoid_print
      print('SharedPreferences has not been initialized yet.');
    }
    return _prefs.getString('token');
  }

  Future<void> setUsername(String username) async {
    await _initialize();
    _prefs.setString('username', username);
  }

  Future<String?> getUsername() async {
    if (!_isInitialized()) {
      // ignore: avoid_print
      print('SharedPreferences has not been initialized yet.');
    }
    return _prefs.getString('username');
  }

  Future<void> removeUsername() async {
    await _initialize();
    await _prefs.remove('username');
  }

  Future<void> removeToken() async {
    await _initialize();
    await _prefs.remove('token');
  }

  bool _isInitialized() {
    // ignore: unnecessary_null_comparison, dead_code
    if (_prefs == null) {
      if (kDebugMode) {
        print('SharedPreferences has not been initialized yet.');
      }
      return false;
    }
    return true;
  }
}
