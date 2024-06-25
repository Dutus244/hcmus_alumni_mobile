import 'package:hcmus_alumni_mobile/common/values/constants.dart';
import 'package:hcmus_alumni_mobile/common/values/permissions.dart';
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

  // Value
  String getDeviceLanguage() {
    return _prefs.getString(AppConstants.DEVICE_LANGUAGE) ?? 'vi';
  }

  bool getDeviceFirstOpen() {
    return _prefs.getBool(AppConstants.DEVICE_OPEN_FIRST_TIME) ?? true;
  }

  bool getUserRememberLogin() {
    return _prefs.getBool(AppConstants.USER_REMEMBER_LOGIN) ?? false;
  }

  String getUserAuthToken() {
    return _prefs.getString(AppConstants.USER_AUTH_TOKEN) ?? '';
  }

  String getUserEmail() {
    return _prefs.getString(AppConstants.USER_EMAIL) ?? '';
  }

  String getUserPassword() {
    return _prefs.getString(AppConstants.USER_PASSWORD) ?? '';
  }

  String getUserFullName() {
    return _prefs.getString(AppConstants.USER_FULL_NAME) ?? '';
  }

  String getUserAvatarUrl() {
    return _prefs.getString(AppConstants.USER_AVATAR_URL) ?? '';
  }

  String getUserId() {
    return _prefs.getString(AppConstants.USER_ID) ?? '';
  }

  // Permission
  bool permissionNewsCommentCreate() {
    return _prefs.getBool(AppPermissions.NEWS_COMMENT_CREATE) ?? false;
  }

  bool permissionEventCommentCreate() {
    return _prefs.getBool(AppPermissions.EVENT_COMMENT_CREATE) ?? false;
  }

  bool permissionEventParticipantCreate() {
    return _prefs.getBool(AppPermissions.EVENT_PARTICIPANT_CREATE) ?? false;
  }

  bool permissionCounselCreate() {
    return _prefs.getBool(AppPermissions.COUNSEL_CREATE) ?? false;
  }

  bool permissionCounselReactionCreate() {
    return _prefs.getBool(AppPermissions.COUNSEL_REACTION_CREATE) ?? false;
  }

  bool permissionCounselCommentCreate() {
    return _prefs.getBool(AppPermissions.COUNSEL_COMMENT_CREATE) ?? false;
  }

  bool permissionCounselVote() {
    return _prefs.getBool(AppPermissions.COUNSEL_VOTE) ?? false;
  }

  bool permissionGroupCreate() {
    return _prefs.getBool(AppPermissions.GROUP_CREATE) ?? false;
  }

  bool permissionProfileEdit() {
    return _prefs.getBool(AppPermissions.PROFILE_EDIT) ?? false;
  }
}
