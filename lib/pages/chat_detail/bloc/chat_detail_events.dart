import 'dart:io';

import 'package:hcmus_alumni_mobile/model/message.dart';
import 'package:photo_manager/photo_manager.dart';

import 'chat_detail_states.dart';

abstract class ChatDetailEvent {
  const ChatDetailEvent();
}

class ModeEvent extends ChatDetailEvent {
  final int mode;

  const ModeEvent(this.mode);
}

class ContentEvent extends ChatDetailEvent {
  final String content;

  const ContentEvent(this.content);
}

class StatusEvent extends ChatDetailEvent {
  final Status status;

  const StatusEvent(this.status);
}

class MessagesEvent extends ChatDetailEvent {
  final List<Message> messages;

  const MessagesEvent(this.messages);
}

class IndexMessageEvent extends ChatDetailEvent {
  final int indexMessage;

  const IndexMessageEvent(this.indexMessage);
}

class HasReachedMaxMessageEvent extends ChatDetailEvent {
  final bool hasReachedMaxMessage;

  const HasReachedMaxMessageEvent(this.hasReachedMaxMessage);
}

class ChildrenEvent extends ChatDetailEvent {
  final Message children;

  const ChildrenEvent(this.children);
}

class ModeImageEvent extends ChatDetailEvent {
  final bool modeImage;

  const ModeImageEvent(this.modeImage);
}

class StatusDeviceImagesEvent extends ChatDetailEvent {
  final Status statusDeviceImages;

  const StatusDeviceImagesEvent(this.statusDeviceImages);
}

class DeviceImagesEvent extends ChatDetailEvent {
  final List<File> deviceImages;

  const DeviceImagesEvent(this.deviceImages);
}

class IndexDeviceImageEvent extends ChatDetailEvent {
  final int indexDeviceImage;

  const IndexDeviceImageEvent(this.indexDeviceImage);
}

class HasReachedMaxDeviceImageEvent extends ChatDetailEvent {
  final bool hasReachedMaxDeviceImage;

  const HasReachedMaxDeviceImageEvent(this.hasReachedMaxDeviceImage);
}

class ImagesEvent extends ChatDetailEvent {
  final List<File> images;

  const ImagesEvent(this.images);
}

class ChatDetailResetEvent extends ChatDetailEvent {}