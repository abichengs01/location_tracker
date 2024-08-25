import 'package:shared_preferences/shared_preferences.dart';

import '../config/app_const.dart';

class SharedPrefs {
  static SharedPreferences? _sharedPrefs;
  static Future<void> initialize() async {
    if (_sharedPrefs != null) {
      return;
    } else {
      _sharedPrefs = await SharedPreferences.getInstance();
    }
  }

  Future<void> saveUserToken(String token) async {
    await _sharedPrefs!.setString(AppConstants.tokenKey, token);
  }

  Future<void> saveUserName(String name) async {
    await _sharedPrefs!.setString(AppConstants.nameKey, name);
  }

  Future<void> saveUserEmail(String email) async {
    await _sharedPrefs!.setString(AppConstants.mailIdKey, email);
  }

  Future<void> saveCount(int count) async {
    await _sharedPrefs!.setInt(AppConstants.count, count);
  }

  Future<void> removeUserNameToken() async {
    await _sharedPrefs!.remove(AppConstants.tokenKey);
    await _sharedPrefs!.remove(AppConstants.nameKey);
    await _sharedPrefs!.remove(AppConstants.mailIdKey);
  }

  static String? get getUserToken =>
      _sharedPrefs!.getString(AppConstants.tokenKey);

  static int? get getUserCount => _sharedPrefs!.getInt(AppConstants.count);

  static String? get getUserName =>
      _sharedPrefs!.getString(AppConstants.nameKey);

  static String? get getEmail =>
      _sharedPrefs!.getString(AppConstants.mailIdKey);
}
