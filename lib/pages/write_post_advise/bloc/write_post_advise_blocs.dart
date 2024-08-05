import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hcmus_alumni_mobile/pages/write_post_advise/bloc/write_post_advise_events.dart';
import 'package:hcmus_alumni_mobile/pages/write_post_advise/bloc/write_post_advise_states.dart';

class WritePostAdviseBloc
    extends Bloc<WritePostAdviseEvent, WritePostAdviseState> {
  WritePostAdviseBloc() : super(WritePostAdviseState()) {
    on<TitleEvent>(_titleEvent);
    on<ContentEvent>(_contentEvent);
    on<TagsEvent>(_tagsEvent);
    on<VotesEvent>(_votesEvent);
    on<PicturesEvent>(_picturesEvent);
    on<PageEvent>(_pageEvent);
    on<AllowAddOptionsEvent>(_allowAddOptionsEvent);
    on<AllowMultipleVotesEvent>(_allowMultipleVotesEvent);
    on<IsLoadingEvent>(_isLoadingEvent);
    on<WritePostAdviseResetEvent>(_writePostAdviseResetEvent);
  }

  void _titleEvent(TitleEvent event, Emitter<WritePostAdviseState> emit) {
    emit(state.copyWith(title: event.title));
  }

  void _contentEvent(ContentEvent event, Emitter<WritePostAdviseState> emit) {
    emit(state.copyWith(content: event.content));
  }

  void _tagsEvent(TagsEvent event, Emitter<WritePostAdviseState> emit) {
    emit(state.copyWith(tags: event.tags));
  }

  void _votesEvent(VotesEvent event, Emitter<WritePostAdviseState> emit) {
    emit(state.copyWith(votes: event.votes));
  }

  void _picturesEvent(PicturesEvent event, Emitter<WritePostAdviseState> emit) {
    emit(state.copyWith(pictures: event.pictures));
  }

  void _pageEvent(PageEvent event, Emitter<WritePostAdviseState> emit) {
    emit(state.copyWith(page: event.page));
  }

  void _allowAddOptionsEvent(AllowAddOptionsEvent event, Emitter<WritePostAdviseState> emit) {
    emit(state.copyWith(allowAddOptions: event.allowAddOptions));
  }

  void _allowMultipleVotesEvent(AllowMultipleVotesEvent event, Emitter<WritePostAdviseState> emit) {
    emit(state.copyWith(allowMultipleVotes: event.allowMultipleVotes));
  }

  void _isLoadingEvent(IsLoadingEvent event, Emitter<WritePostAdviseState> emit) {
    emit(state.copyWith(isLoading: event.isLoading));
  }

  void _writePostAdviseResetEvent(
      WritePostAdviseResetEvent event, Emitter<WritePostAdviseState> emit) {
    emit(WritePostAdviseState()); // Reset the state to its initial state
  }
}
