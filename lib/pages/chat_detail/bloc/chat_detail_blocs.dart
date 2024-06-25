import 'package:flutter_bloc/flutter_bloc.dart';

import 'chat_detail_events.dart';
import 'chat_detail_states.dart';

class ChatDetailBloc extends Bloc<ChatDetailEvent, ChatDetailState> {
  ChatDetailBloc() : super(ChatDetailState()) {
    on<StatusEvent>(_statusEvent);
    on<ModeEvent>(_modeEvent);
    on<ContentEvent>(_contentEvent);
    on<MessagesEvent>(_messagesEvent);
    on<IndexMessageEvent>(_indexMessageEvent);
    on<HasReachedMaxMessageEvent>(_hasReachedMaxMessageEvent);
    on<ChildrenEvent>(_childrenEvent);
    on<ModeImageEvent>(_modeImageEvent);
    on<DeviceImagesEvent>(_deviceImagesEvent);
    on<StatusDeviceImagesEvent>(_statusDeviceImagesEvent);
    on<ChatDetailResetEvent>(_chatDetailResetEvent);
    on<IndexDeviceImageEvent>(_indexDeviceImageEvent);
    on<HasReachedMaxDeviceImageEvent>(_hasReachedMaxDeviceImageEvent);
    on<ImagesEvent>(_imagesEvent);
  }

  void _statusEvent(StatusEvent event, Emitter<ChatDetailState> emit) async {
    emit(state.copyWith(status: event.status));
  }

  void _modeEvent(ModeEvent event, Emitter<ChatDetailState> emit) async {
    emit(state.copyWith(mode: event.mode));
  }

  void _contentEvent(ContentEvent event, Emitter<ChatDetailState> emit) async {
    emit(state.copyWith(content: event.content));
  }

  void _messagesEvent(MessagesEvent event, Emitter<ChatDetailState> emit) async {
    emit(state.copyWith(messages: event.messages));
  }

  void _indexMessageEvent(IndexMessageEvent event, Emitter<ChatDetailState> emit) {
    emit(state.copyWith(indexMessage: event.indexMessage));
  }

  void _hasReachedMaxMessageEvent(
      HasReachedMaxMessageEvent event, Emitter<ChatDetailState> emit) {
    emit(state.copyWith(hasReachedMaxMessage: event.hasReachedMaxMessage));
  }

  void _childrenEvent(ChildrenEvent event, Emitter<ChatDetailState> emit) async {
    emit(state.copyWith(children: event.children));
  }

  void _modeImageEvent(ModeImageEvent event, Emitter<ChatDetailState> emit) async {
    emit(state.copyWith(modeImage: event.modeImage));
  }

  void _chatDetailResetEvent(ChatDetailResetEvent event, Emitter<ChatDetailState> emit) async {
    emit(ChatDetailState());
  }

  void _deviceImagesEvent(DeviceImagesEvent event, Emitter<ChatDetailState> emit) async {
    emit(state.copyWith(deviceImages: event.deviceImages));
  }

  void _statusDeviceImagesEvent(StatusDeviceImagesEvent event, Emitter<ChatDetailState> emit) async {
    emit(state.copyWith(statusDeviceImage: event.statusDeviceImages));
  }

  void _hasReachedMaxDeviceImageEvent(HasReachedMaxDeviceImageEvent event, Emitter<ChatDetailState> emit) async {
    emit(state.copyWith(hasReachedMaxDeviceImage: event.hasReachedMaxDeviceImage));
  }

  void _indexDeviceImageEvent(IndexDeviceImageEvent event, Emitter<ChatDetailState> emit) async {
    emit(state.copyWith(indexDeviceImage: event.indexDeviceImage));
  }

  void _imagesEvent(ImagesEvent event, Emitter<ChatDetailState> emit) async {
    emit(state.copyWith(images: event.images));
  }
}
