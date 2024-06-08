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

  // Permission
  bool permissionNewsCommentCreate() {
    return _prefs.getBool(Permissions.NEWS_COMMENT_CREATE) ?? false;
  }

  bool permissionEventCommentCreate() {
    return _prefs.getBool(Permissions.EVENT_COMMENT_CREATE) ?? false;
  }

  bool permissionEventParticipantCreate() {
    return _prefs.getBool(Permissions.EVENT_PARTICIPANT_CREATE) ?? false;
  }

  bool permissionCounselCreate() {
    return _prefs.getBool(Permissions.COUNSEL_CREATE) ?? false;
  }

  bool permissionCounselReactionCreate() {
    return _prefs.getBool(Permissions.COUNSEL_REACTION_CREATE) ?? false;
  }

  bool permissionCounselCommentCreate() {
    return _prefs.getBool(Permissions.COUNSEL_COMMENT_CREATE) ?? false;
  }

  bool permissionCounselVote() {
    return _prefs.getBool(Permissions.COUNSEL_VOTE) ?? false;
  }

  bool permissionGroupCreate() {
    return _prefs.getBool(Permissions.GROUP_CREATE) ?? false;
  }

  bool permissionProfileEdit() {
    return _prefs.getBool(Permissions.PROFILE_EDIT) ?? false;
  }

  bool permissionMessageCreate() {
    return _prefs.getBool(Permissions.MESSAGE_CREATE) ?? false;
  }
}
