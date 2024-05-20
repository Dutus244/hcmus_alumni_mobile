import 'package:hcmus_alumni_mobile/common/values/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  late final SharedPreferences _prefs;

  Future<StorageService> init() async {
    _prefs = await SharedPreferences.getInstance();
    return this;
  }

  Future<bool> setBool(String key, bool value) async {
    return await _prefs.setBool(key, value);
  }

  Future<bool> setString(String key, String value) async {
    return await _prefs.setString(key, value);
  }

  bool getDeviceFirstOpen() {
    return _prefs.getBool(AppConstants.STORAGE_DEVICE_OPEN_FIRST_TIME) ?? true;
  }

  bool getUserIsLoggedIn() {
    return _prefs.getBool(AppConstants.STORAGE_USER_IS_LOGGED_IN) ?? false;
  }

  bool getUserRememberLogin() {
    return _prefs.getBool(AppConstants.STORAGE_USER_REMEMBER_LOGIN) ?? false;
  }

  String getUserAuthToken() {
    return _prefs.getString(AppConstants.STORAGE_USER_AUTH_TOKEN) ?? '';
  }

  String getUserEmail() {
    return _prefs.getString(AppConstants.STORAGE_USER_EMAIL) ?? '';
  }

  String getUserPassword() {
    return _prefs.getString(AppConstants.STORAGE_USER_PASSWORD) ?? '';
  }

  String getUserFullName() {
    return _prefs.getString(AppConstants.STORAGE_USER_FULL_NAME) ?? '';
  }

  String getUserAvatarUrl() {
    return _prefs.getString(AppConstants.STORAGE_USER_AVATAR_URL) ?? '';
  }
}
