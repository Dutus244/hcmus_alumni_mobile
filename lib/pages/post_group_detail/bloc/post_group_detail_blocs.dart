import 'package:flutter_bloc/flutter_bloc.dart';

import 'post_group_detail_events.dart';
import 'post_group_detail_states.dart';

class PostGroupDetailBloc
    extends Bloc<PostGroupDetailEvent, PostGroupDetailState> {
  PostGroupDetailBloc() : super(PostGroupDetailState()) {
    on<PostEvent>(_postEvent);
    on<StatusCommentEvent>(_statusCommentEvent);
    on<CommentsEvent>(_commentsEvent);
    on<IndexCommentEvent>(_indexCommentEvent);
    on<HasReachedMaxCommentEvent>(_hasReachedMaxCommentEvent);
    on<ContentEvent>(_contentEvent);
    on<ChildrenEvent>(_childrenEvent);
    on<ReplyEvent>(_replyEvent);
    on<IsLoadingEvent>(_isLoadingEvent);
  }

  void _postEvent(PostEvent event,
      Emitter<PostGroupDetailState> emit) async {
    emit(state.copyWith(post: event.post));
  }

  void _statusCommentEvent(StatusCommentEvent event,
      Emitter<PostGroupDetailState> emit) async {
    emit(state.copyWith(statusComment: event.statusComment));
  }

  void _commentsEvent(
      CommentsEvent event, Emitter<PostGroupDetailState> emit) async {
    emit(state.copyWith(comments: event.comments));
  }

  void _indexCommentEvent(
      IndexCommentEvent event, Emitter<PostGroupDetailState> emit) {
    emit(state.copyWith(indexComment: event.indexComment));
  }

  void _hasReachedMaxCommentEvent(HasReachedMaxCommentEvent event,
      Emitter<PostGroupDetailState> emit) {
    emit(state.copyWith(hasReachedMaxComment: event.hasReachedMaxComment));
  }

  void _contentEvent(
      ContentEvent event, Emitter<PostGroupDetailState> emit) {
    emit(state.copyWith(content: event.content));
  }

  void _childrenEvent(
      ChildrenEvent event, Emitter<PostGroupDetailState> emit) {
    emit(state.copyWith(children: event.children));
  }

  void _replyEvent(ReplyEvent event, Emitter<PostGroupDetailState> emit) {
    emit(state.copyWith(reply: event.reply));
  }

  void _isLoadingEvent(IsLoadingEvent event, Emitter<PostGroupDetailState> emit) {
    emit(state.copyWith(isLoading: event.isLoading));
  }
}
