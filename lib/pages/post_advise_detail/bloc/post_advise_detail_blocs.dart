import 'package:flutter_bloc/flutter_bloc.dart';

import 'post_advise_detail_events.dart';
import 'post_advise_detail_states.dart';

class PostAdviseDetailBloc
    extends Bloc<PostAdviseDetailEvent, PostAdviseDetailState> {
  PostAdviseDetailBloc() : super(PostAdviseDetailState()) {
    on<PostEvent>(_postEvent);
    on<StatusCommentEvent>(_statusCommentEvent);
    on<CommentsEvent>(_commentsEvent);
    on<IndexCommentEvent>(_indexCommentEvent);
    on<HasReachedMaxCommentEvent>(_hasReachedMaxCommentEvent);
    on<ContentEvent>(_contentEvent);
    on<ChildrenEvent>(_childrenEvent);
    on<ReplyEvent>(_replyEvent);
  }

  void _postEvent(PostEvent event,
      Emitter<PostAdviseDetailState> emit) async {
    emit(state.copyWith(post: event.post));
  }

  void _statusCommentEvent(StatusCommentEvent event,
      Emitter<PostAdviseDetailState> emit) async {
    emit(state.copyWith(statusComment: event.statusComment));
  }

  void _commentsEvent(
      CommentsEvent event, Emitter<PostAdviseDetailState> emit) async {
    emit(state.copyWith(comments: event.comments));
  }

  void _indexCommentEvent(
      IndexCommentEvent event, Emitter<PostAdviseDetailState> emit) {
    emit(state.copyWith(indexComment: event.indexComment));
  }

  void _hasReachedMaxCommentEvent(HasReachedMaxCommentEvent event,
      Emitter<PostAdviseDetailState> emit) {
    emit(state.copyWith(hasReachedMaxComment: event.hasReachedMaxComment));
  }

  void _contentEvent(
      ContentEvent event, Emitter<PostAdviseDetailState> emit) {
    emit(state.copyWith(content: event.content));
  }

  void _childrenEvent(
      ChildrenEvent event, Emitter<PostAdviseDetailState> emit) {
    emit(state.copyWith(children: event.children));
  }

  void _replyEvent(ReplyEvent event, Emitter<PostAdviseDetailState> emit) {
    emit(state.copyWith(reply: event.reply));
  }
}
