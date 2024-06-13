import 'package:flutter_bloc/flutter_bloc.dart';

import 'friend_page_events.dart';
import 'friend_page_states.dart';

class NotificationPageBloc extends Bloc<NotificationPageEvent, FriendPageState> {
  NotificationPageBloc() : super(FriendPageState()) {
    on<StatusNotificationEvent>(_statusNotificationEvent);
    on<NotificationsEvent>(_notificationsEvent);
    on<IndexNotificationEvent>(_indexNotificationEvent);
    on<HasReachedMaxNotificationEvent>(_hasReachedMaxNotificationEvent);
  }

  void _statusNotificationEvent(
      StatusNotificationEvent event, Emitter<FriendPageState> emit) async {
    emit(state.copyWith(statusNotification: event.statusNotification));
  }

  void _notificationsEvent(NotificationsEvent event, Emitter<FriendPageState> emit) async {
    emit(state.copyWith(notifications: event.notifications));
  }

  void _indexNotificationEvent(
      IndexNotificationEvent event, Emitter<FriendPageState> emit) {
    emit(state.copyWith(indexNotification: event.indexNotification));
  }

  void _hasReachedMaxNotificationEvent(
      HasReachedMaxNotificationEvent event, Emitter<FriendPageState> emit) {
    emit(state.copyWith(hasReachedMaxNotification: event.hasReachedMaxNotification));
  }
}