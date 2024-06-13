import 'package:hcmus_alumni_mobile/model/notification.dart';

enum Status { loading, success }

class FriendPageState {
  final int page;

  final Status statusNotification;
  final List<Notifications> notifications;
  final int indexNotification;
  final bool hasReachedMaxNotification;

  FriendPageState({
    this.page = 0,
    this.statusNotification = Status.loading,
    this.notifications = const [],
    this.indexNotification = 0,
    this.hasReachedMaxNotification = false,
  });

  FriendPageState copyWith({
    Status? statusNotification,
    List<Notifications>? notifications,
    int? indexNotification,
    bool? hasReachedMaxNotification,
  }) {
    return FriendPageState(
        statusNotification: statusNotification ?? this.statusNotification,
        notifications: notifications ?? this.notifications,
        indexNotification: indexNotification ?? this.indexNotification,
        hasReachedMaxNotification: hasReachedMaxNotification ?? this.hasReachedMaxNotification);
  }
}