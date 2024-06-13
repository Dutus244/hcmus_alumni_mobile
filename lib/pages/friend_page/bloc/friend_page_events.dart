import 'package:hcmus_alumni_mobile/model/notification.dart';

import 'friend_page_states.dart';

class NotificationPageEvent {
  const NotificationPageEvent();
}

class StatusNotificationEvent extends NotificationPageEvent {
  final Status statusNotification;

  const StatusNotificationEvent(this.statusNotification);
}

class NotificationsEvent extends NotificationPageEvent {
  final List<Notifications> notifications;

  const NotificationsEvent(this.notifications);
}

class IndexNotificationEvent extends NotificationPageEvent {
  final int indexNotification;

  const IndexNotificationEvent(this.indexNotification);
}

class HasReachedMaxNotificationEvent extends NotificationPageEvent {
  final bool hasReachedMaxNotification;

  const HasReachedMaxNotificationEvent(this.hasReachedMaxNotification);
}