import 'package:flutter_bloc/flutter_bloc.dart';

import 'list_comment_post_advise_events.dart';
import 'list_comment_post_advise_states.dart';

class ListCommentPostAdviseBloc
    extends Bloc<ListCommentPostAdviseEvent, ListCommentPostAdviseState> {
  ListCommentPostAdviseBloc() : super(ListCommentPostAdviseState()) {
    on<StatusCommentEvent>(_statusCommentEvent);
    on<CommentsEvent>(_commentsEvent);
    on<IndexCommentEvent>(_indexCommentEvent);
    on<HasReachedMaxCommentEvent>(_hasReachedMaxCommentEvent);
    on<ContentEvent>(_contentEvent);
    on<ChildrenEvent>(_childrenEvent);
    on<ReplyEvent>(_replyEvent);
  }

  void _statusCommentEvent(StatusCommentEvent event,
      Emitter<ListCommentPostAdviseState> emit) async {
    emit(state.copyWith(statusComment: event.statusComment));
  }

  void _commentsEvent(
      CommentsEvent event, Emitter<ListCommentPostAdviseState> emit) async {
    emit(state.copyWith(comments: event.comments));
  }

  void _indexCommentEvent(
      IndexCommentEvent event, Emitter<ListCommentPostAdviseState> emit) {
    emit(state.copyWith(indexComment: event.indexComment));
  }

  void _hasReachedMaxCommentEvent(HasReachedMaxCommentEvent event,
      Emitter<ListCommentPostAdviseState> emit) {
    emit(state.copyWith(hasReachedMaxComment: event.hasReachedMaxComment));
  }

  void _contentEvent(
      ContentEvent event, Emitter<ListCommentPostAdviseState> emit) {
    emit(state.copyWith(content: event.content));
  }

  void _childrenEvent(
      ChildrenEvent event, Emitter<ListCommentPostAdviseState> emit) {
    emit(state.copyWith(children: event.children));
  }

  void _replyEvent(ReplyEvent event, Emitter<ListCommentPostAdviseState> emit) {
    emit(state.copyWith(reply: event.reply));
  }
}
