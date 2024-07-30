import 'package:hcmus_alumni_mobile/model/notification.dart';

class NotificationResponse {
  final List<Notifications> notifications;

  NotificationResponse(this.notifications);

  NotificationResponse.fromJson(Map<String, dynamic> json)
      : notifications = (json["notifications"] as List)
            .map((i) => new Notifications.fromJson(i))
            .toList();
}
