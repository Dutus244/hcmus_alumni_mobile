import 'package:flutter_bloc/flutter_bloc.dart';

import 'list_comment_post_group_events.dart';
import 'list_comment_post_group_states.dart';

class ListCommentPostGroupBloc
    extends Bloc<ListCommentPostGroupEvent, ListCommentPostGroupState> {
  ListCommentPostGroupBloc() : super(ListCommentPostGroupState()) {
    on<StatusCommentEvent>(_statusCommentEvent);
    on<CommentsEvent>(_commentsEvent);
    on<IndexCommentEvent>(_indexCommentEvent);
    on<HasReachedMaxCommentEvent>(_hasReachedMaxCommentEvent);
    on<ContentEvent>(_contentEvent);
    on<ChildrenEvent>(_childrenEvent);
    on<ReplyEvent>(_replyEvent);
  }

  void _statusCommentEvent(StatusCommentEvent event,
      Emitter<ListCommentPostGroupState> emit) async {
    emit(state.copyWith(statusComment: event.statusComment));
  }

  void _commentsEvent(
      CommentsEvent event, Emitter<ListCommentPostGroupState> emit) async {
    emit(state.copyWith(comments: event.comments));
  }

  void _indexCommentEvent(
      IndexCommentEvent event, Emitter<ListCommentPostGroupState> emit) {
    emit(state.copyWith(indexComment: event.indexComment));
  }

  void _hasReachedMaxCommentEvent(HasReachedMaxCommentEvent event,
      Emitter<ListCommentPostGroupState> emit) {
    emit(state.copyWith(hasReachedMaxComment: event.hasReachedMaxComment));
  }

  void _contentEvent(
      ContentEvent event, Emitter<ListCommentPostGroupState> emit) {
    emit(state.copyWith(content: event.content));
  }

  void _childrenEvent(
      ChildrenEvent event, Emitter<ListCommentPostGroupState> emit) {
    emit(state.copyWith(children: event.children));
  }

  void _replyEvent(ReplyEvent event, Emitter<ListCommentPostGroupState> emit) {
    emit(state.copyWith(reply: event.reply));
  }
}
