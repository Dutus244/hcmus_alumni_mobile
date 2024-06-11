import 'package:hcmus_alumni_mobile/model/notification.dart';

enum Status { loading, success }

class NotificationPageState {
  final Status statusNotification;
  final List<Notifications> notifications;
  final int indexNotification;
  final bool hasReachedMaxNotification;

  NotificationPageState({
    this.statusNotification = Status.loading,
    this.notifications = const [],
    this.indexNotification = 0,
    this.hasReachedMaxNotification = false,
  });

  NotificationPageState copyWith({
    Status? statusNotification,
    List<Notifications>? notifications,
    int? indexNotification,
    bool? hasReachedMaxNotification,
  }) {
    return NotificationPageState(
        statusNotification: statusNotification ?? this.statusNotification,
        notifications: notifications ?? this.notifications,
        indexNotification: indexNotification ?? this.indexNotification,
        hasReachedMaxNotification: hasReachedMaxNotification ?? this.hasReachedMaxNotification);
  }
}