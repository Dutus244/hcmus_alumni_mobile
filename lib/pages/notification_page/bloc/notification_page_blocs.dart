import 'package:flutter_bloc/flutter_bloc.dart';

import 'notification_page_events.dart';
import 'notification_page_states.dart';

class NotificationPageBloc extends Bloc<NotificationPageEvent, NotificationPageState> {
  NotificationPageBloc() : super(NotificationPageState()) {
    on<StatusNotificationEvent>(_statusNotificationEvent);
    on<NotificationsEvent>(_notificationsEvent);
    on<IndexNotificationEvent>(_indexNotificationEvent);
    on<HasReachedMaxNotificationEvent>(_hasReachedMaxNotificationEvent);
  }

  void _statusNotificationEvent(
      StatusNotificationEvent event, Emitter<NotificationPageState> emit) async {
    emit(state.copyWith(statusNotification: event.statusNotification));
  }

  void _notificationsEvent(NotificationsEvent event, Emitter<NotificationPageState> emit) async {
    emit(state.copyWith(notifications: event.notifications));
  }

  void _indexNotificationEvent(
      IndexNotificationEvent event, Emitter<NotificationPageState> emit) {
    emit(state.copyWith(indexNotification: event.indexNotification));
  }

  void _hasReachedMaxNotificationEvent(
      HasReachedMaxNotificationEvent event, Emitter<NotificationPageState> emit) {
    emit(state.copyWith(hasReachedMaxNotification: event.hasReachedMaxNotification));
  }
}