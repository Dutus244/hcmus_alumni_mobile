import 'package:hcmus_alumni_mobile/model/user.dart';
import 'package:hcmus_alumni_mobile/model/status.dart';

class Notifications {
  final String id;
  final User notifier;
  final User actor;
  final String entityId;
  final String entityTable;
  final String notificationType;
  final String createAt;
  final Status status;
  final String notificationImageUrl;
  final String notificationMessage;
  final String parentId;

  Notifications(
      this.id,
      this.notifier,
      this.actor,
      this.entityId,
      this.entityTable,
      this.notificationType,
      this.createAt,
      this.status,
      this.notificationImageUrl,
      this.notificationMessage,
      this.parentId);

  Notifications.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        notifier = User.fromJson(json["notifier"]),
        actor = User.fromJson(json["actor"]),
        entityId = json["entityId"] ?? "",
        entityTable = json["entityTable"] ?? "",
        notificationType = json["notificationType"] ?? "",
        createAt = json["createAt"] ?? "",
        status = Status.fromJson(json["status"]),
        notificationImageUrl = json["notificationImageUrl"] ?? "",
        notificationMessage = json["notificationMessage"] ?? "",
        parentId = json["parentId"] ?? "";
}
