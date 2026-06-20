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

  Future<void> setUserName(String name) async {
    await _initialize();
    await _prefs.setString("userNameKey", name);
  }

  Future<void> setGovernmentEntity(String entity) async {
    await _initialize();
    await _prefs.setString("governmentEntityKey", entity);
  }

  Future<void> setImageUrl(String imageUrl) async {
    await _initialize();
    await _prefs.setString("imageUrlKey", imageUrl);
  }

  String getUserName() {
    return _prefs.getString("userNameKey") ?? '';
  }

  String getGovernmentEntity() {
    return _prefs.getString("governmentEntityKey") ?? '';
  }

  String getImageUrl() {
    return _prefs.getString("imageUrlKey") ?? '';
  }

  String? getToken() {
    if (!_isInitialized()) {
      // ignore: avoid_print
      print('SharedPreferences has not been initialized yet.');
    }
    return _prefs.getString('token');
  }

  Future<void> removeToken() async {
    await _initialize();
    await _prefs.remove('token');
  }

  Future<void> removeUserName() async {
    await _initialize();
    await _prefs.remove("userNameKey");
  }

  Future<void> removeGovernmentEntity() async {
    await _initialize();
    await _prefs.remove("governmentEntityKey");
  }

  Future<void> removeImageUrl() async {
    await _initialize();
    await _prefs.remove("imageUrlKey");
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
