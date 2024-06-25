import 'dart:io';

import 'package:hcmus_alumni_mobile/model/message.dart';

enum Status { loading, success }

class ChatDetailState {
  final int mode;
  final String content;
  final Status status;
  final List<Message> messages;
  final int indexMessage;
  final bool hasReachedMaxMessage;
  final Message? children;
  final bool? modeImage;
  final Status statusDeviceImage;
  final List<File> deviceImages;
  final int indexDeviceImage;
  final bool hasReachedMaxDeviceImage;
  final List<File> images;

  const ChatDetailState({
    this.mode = 0,
    this.content = "",
    this.status = Status.loading,
    this.messages = const [],
    this.indexMessage = 0,
    this.hasReachedMaxMessage = false,
    this.children = null,
    this.modeImage = false,
    this.statusDeviceImage = Status.loading,
    this.deviceImages = const [],
    this.indexDeviceImage = 0,
    this.hasReachedMaxDeviceImage = false,
    this.images = const []
  });

  ChatDetailState copyWith({
    int? mode,
    String? content,
    Status? status,
    List<Message>? messages,
    int? indexMessage,
    bool? hasReachedMaxMessage,
    Message? children,
    bool? modeImage,
    Status? statusDeviceImage,
    List<File>? deviceImages,
    int? indexDeviceImage,
    bool? hasReachedMaxDeviceImage,
    List<File>? images
  }) {
    return ChatDetailState(
      mode: mode ?? this.mode,
      content: content ?? this.content,
      status: status ?? this.status,
      messages: messages ?? this.messages,
      indexMessage: indexMessage ?? this.indexMessage,
      hasReachedMaxMessage: hasReachedMaxMessage ?? this.hasReachedMaxMessage,
      children: children ?? this.children,
      modeImage: modeImage ?? this.modeImage,
      statusDeviceImage: statusDeviceImage ?? this.statusDeviceImage,
      deviceImages: deviceImages ?? this.deviceImages,
      indexDeviceImage: indexDeviceImage ?? this.indexDeviceImage,
      hasReachedMaxDeviceImage: hasReachedMaxDeviceImage ?? this.hasReachedMaxDeviceImage,
      images: images ?? this.images,
    );
  }
}
