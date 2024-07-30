import '../../global.dart';
import '../values/permissions.dart';

bool hasPermission(List<String> permissions, String permissionToCheck) {
  return permissions.contains(permissionToCheck);
}

Future<void> handleSavePermission(List<String> permissions) async {
  if (hasPermission(permissions, AppPermissions.NEWS_COMMENT_CREATE)) {
    Global.storageService.setBool(AppPermissions.NEWS_COMMENT_CREATE, true);
  } else {
    Global.storageService.setBool(AppPermissions.NEWS_COMMENT_CREATE, false);
  }

  if (hasPermission(permissions, AppPermissions.EVENT_COMMENT_CREATE)) {
    Global.storageService.setBool(AppPermissions.EVENT_COMMENT_CREATE, true);
  } else {
    Global.storageService.setBool(AppPermissions.EVENT_COMMENT_CREATE, false);
  }

  if (hasPermission(permissions, AppPermissions.EVENT_PARTICIPANT_CREATE)) {
    Global.storageService
        .setBool(AppPermissions.EVENT_PARTICIPANT_CREATE, true);
  } else {
    Global.storageService
        .setBool(AppPermissions.EVENT_PARTICIPANT_CREATE, false);
  }

  if (hasPermission(permissions, AppPermissions.COUNSEL_CREATE)) {
    Global.storageService.setBool(AppPermissions.COUNSEL_CREATE, true);
  } else {
    Global.storageService.setBool(AppPermissions.COUNSEL_CREATE, false);
  }

  if (hasPermission(permissions, AppPermissions.COUNSEL_REACTION_CREATE)) {
    Global.storageService.setBool(AppPermissions.COUNSEL_REACTION_CREATE, true);
  } else {
    Global.storageService
        .setBool(AppPermissions.COUNSEL_REACTION_CREATE, false);
  }

  if (hasPermission(permissions, AppPermissions.COUNSEL_COMMENT_CREATE)) {
    Global.storageService.setBool(AppPermissions.COUNSEL_COMMENT_CREATE, true);
  } else {
    Global.storageService.setBool(AppPermissions.COUNSEL_COMMENT_CREATE, false);
  }

  if (hasPermission(permissions, AppPermissions.COUNSEL_VOTE)) {
    Global.storageService.setBool(AppPermissions.COUNSEL_VOTE, true);
  } else {
    Global.storageService.setBool(AppPermissions.COUNSEL_VOTE, false);
  }

  if (hasPermission(permissions, AppPermissions.GROUP_CREATE)) {
    Global.storageService.setBool(AppPermissions.GROUP_CREATE, true);
  } else {
    Global.storageService.setBool(AppPermissions.GROUP_CREATE, false);
  }

  if (hasPermission(permissions, AppPermissions.GROUP_JOIN)) {
    Global.storageService.setBool(AppPermissions.GROUP_JOIN, true);
  } else {
    Global.storageService.setBool(AppPermissions.GROUP_JOIN, false);
  }

  if (hasPermission(permissions, AppPermissions.PROFILE_EDIT)) {
    Global.storageService.setBool(AppPermissions.PROFILE_EDIT, true);
  } else {
    Global.storageService.setBool(AppPermissions.PROFILE_EDIT, false);
  }
}
