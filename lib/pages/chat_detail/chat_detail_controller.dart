import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_translate/flutter_translate.dart';

import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_manager/photo_manager.dart';

import '../../common/services/socket_service.dart';
import '../../common/widgets/flutter_toast.dart';
import '../../global.dart';
import '../../model/message_response.dart';
import '../../model/message.dart';
import 'bloc/chat_detail_blocs.dart';
import 'bloc/chat_detail_events.dart';
import 'bloc/chat_detail_states.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';

class ChatDetailController {
  final BuildContext context;
  OverlayEntry? _overlayEntry;

  ChatDetailController({required this.context});

  void showLoadingIndicator() {
    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        bottom: MediaQuery.of(context).size.height * 0.5 - 30,
        left: MediaQuery.of(context).size.width * 0.5 - 30,
        child: Material(
          type: MaterialType.transparency,
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.black54,
              borderRadius: BorderRadius.circular(10),
            ),
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  void hideLoadingIndicator() {
    if (_overlayEntry != null) {
      _overlayEntry!.remove();
      _overlayEntry = null;
    }
  }

  Future<void> handleLoadMessageData(int page, int inboxId) async {
    if (page == 0) {
      context.read<ChatDetailBloc>().add(HasReachedMaxMessageEvent(false));
      context.read<ChatDetailBloc>().add(IndexMessageEvent(1));
    } else {
      if (BlocProvider.of<ChatDetailBloc>(context).state.hasReachedMaxMessage) {
        return;
      }
      context.read<ChatDetailBloc>().add(IndexMessageEvent(
          BlocProvider.of<ChatDetailBloc>(context).state.indexMessage + 1));
    }

    var apiUrl = dotenv.env['API_URL'];
    var endpoint = '/messages/inbox/$inboxId';
    var pageSize = 20;

    var token = Global.storageService.getUserAuthToken();

    var headers = <String, String>{
      'Authorization': 'Bearer $token', // Include bearer token in the headers
    };

    try {
      var url = Uri.parse('$apiUrl$endpoint?page=$page&pageSize=$pageSize');

      // Specify UTF-8 encoding for decoding response
      var response = await http.get(url, headers: headers);
      var responseBody = utf8.decode(response.bodyBytes);
      if (response.statusCode == 200) {
        // Convert the JSON string to a Map
        var jsonMap = json.decode(responseBody);
        // Pass the Map to the fromJson method
        var messageResponse = MessageResponse.fromJson(jsonMap);
        if (messageResponse.messages.isEmpty) {
          if (page == 0) {
            context
                .read<ChatDetailBloc>()
                .add(MessagesEvent(messageResponse.messages));
          }
          context.read<ChatDetailBloc>().add(HasReachedMaxMessageEvent(true));
          context.read<ChatDetailBloc>().add(StatusEvent(Status.success));
          return;
        }
        if (page == 0) {
          context
              .read<ChatDetailBloc>()
              .add(MessagesEvent(messageResponse.messages));
        } else {
          List<Message> currentList =
              BlocProvider.of<ChatDetailBloc>(context).state.messages;

          // Create a new list by adding newsResponse.news to the existing list
          List<Message> updatedNewsList = List.of(currentList)
            ..addAll(messageResponse.messages);

          context.read<ChatDetailBloc>().add(MessagesEvent(updatedNewsList));
        }
        context.read<ChatDetailBloc>().add(StatusEvent(Status.success));

        if (messageResponse.messages.length < pageSize) {
          context.read<ChatDetailBloc>().add(HasReachedMaxMessageEvent(true));
        }
      } else {
        // Handle other status codes if needed
        toastInfo(msg: translate('error_get_message'));
      }
    } catch (error) {
      // Handle errors
      // toastInfo(msg: translate('error_get_message'));
    }
  }

  Future<void> handleLoadDeviceImages(int page) async {
    if (await Permission.photos.request().isGranted) {
      // Permissions are granted, continue to load images
    } else {
      // Permissions are denied, show a message to the user
    }
    List<AssetPathEntity> albums = await PhotoManager.getAssetPathList(
      type: RequestType.image,
    );

    int pageSize = 6;
    if (page == 0) {
      context.read<ChatDetailBloc>().add(HasReachedMaxDeviceImageEvent(false));
      context.read<ChatDetailBloc>().add(IndexDeviceImageEvent(1));
    } else {
      if (BlocProvider.of<ChatDetailBloc>(context)
          .state
          .hasReachedMaxDeviceImage) {
        return;
      }
      context.read<ChatDetailBloc>().add(IndexDeviceImageEvent(
          BlocProvider.of<ChatDetailBloc>(context).state.indexDeviceImage + 1));
    }
    List<AssetEntity> images =
        await albums[0].getAssetListPaged(page: page, size: pageSize);
    List<File> files = [];
    for (var asset in images) {
      File? file = await asset.file;
      if (file != null) {
        files.add(file);
      }
    }
    if (files.isEmpty) {
      if (page == 0) {
        context.read<ChatDetailBloc>().add(DeviceImagesEvent(files));
      }
      context.read<ChatDetailBloc>().add(HasReachedMaxDeviceImageEvent(true));
      context
          .read<ChatDetailBloc>()
          .add(StatusDeviceImagesEvent(Status.success));
      return;
    }
    if (page == 0) {
      context.read<ChatDetailBloc>().add(DeviceImagesEvent(files));
    } else {
      List<File> currentList =
          BlocProvider.of<ChatDetailBloc>(context).state.deviceImages;

      // Create a new list by adding newsResponse.news to the existing list
      List<File> updatedNewsList = List.of(currentList)..addAll(files);

      context.read<ChatDetailBloc>().add(DeviceImagesEvent(updatedNewsList));
    }
    context.read<ChatDetailBloc>().add(StatusDeviceImagesEvent(Status.success));

    if (files.length < pageSize) {
      context.read<ChatDetailBloc>().add(HasReachedMaxDeviceImageEvent(true));
    }
  }

  Future<File> resizeImageIfNeeded(File imageFile) async {
    const int maxSizeInBytes = 5 * 1024 * 1024; // 5MB
    int imageSize = await imageFile.length();

    if (imageSize <= maxSizeInBytes) {
      return imageFile;
    }

    // Resize the image
    img.Image? image = img.decodeImage(imageFile.readAsBytesSync());
    if (image == null) {
      throw Exception("Could not decode image");
    }

    // Calculate the reduction scale
    double scale = maxSizeInBytes / imageSize;
    int newWidth = (image.width * scale).toInt();
    int newHeight = (image.height * scale).toInt();

    // Resize the image
    img.Image resizedImage =
        img.copyResize(image, width: newWidth, height: newHeight);

    // Save the resized image to a temporary file
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    File resizedFile =
        File('$tempPath/resized_${imageFile.path.split('/').last}');
    resizedFile.writeAsBytesSync(img.encodeJpg(resizedImage, quality: 85));

    return resizedFile;
  }

  Future<void> handleSendMessage(int inboxId) async {
    try {
      String content = BlocProvider.of<ChatDetailBloc>(context).state.content;
      List<File> images = BlocProvider.of<ChatDetailBloc>(context).state.images;
      int mode = BlocProvider.of<ChatDetailBloc>(context).state.mode;
      Message? children =
          BlocProvider.of<ChatDetailBloc>(context).state.children;
      context.read<ChatDetailBloc>().add(IsLoadingEvent(true));
      showLoadingIndicator();
      await Future.delayed(Duration(seconds: 5));
      if (mode == 0) {
        if (content != "") {
          try {
            socketService.sendMessage(inboxId, {
              'content': content,
              'senderId': Global.storageService.getUserId()
            });
          } catch (error) {
            print(error);
            toastInfo(msg: 'Có lỗi trong việc gửi tin nhắn');
          }
        }
        if (images.length > 0) {
          var apiUrl = dotenv.env['API_URL'];
          var endpoint = '/messages/inbox/$inboxId/media';

          var token = Global.storageService.getUserAuthToken();

          var headers = <String, String>{
            'Authorization': 'Bearer $token',
            "Content-Type": "application/json"
            // Include bearer token in the headers
          };

          for (int i = 0; i < images.length; i++) {
            var request =
                http.MultipartRequest('POST', Uri.parse('$apiUrl$endpoint'));
            request.headers.addAll(headers);
            request.fields['messageType'] = 'IMAGE';

            File imageFile = await resizeImageIfNeeded(images[i]);

            request.files.add(
              http.MultipartFile(
                'media',
                imageFile.readAsBytes().asStream(),
                imageFile.lengthSync(),
                filename: imageFile.toString(),
                contentType: MediaType('image', 'jpeg'),
              ),
            );

            try {
              // Send the request
              var streamedResponse = await request.send();

              // Convert the streamed response to a regular HTTP response
              var response = await http.Response.fromStream(streamedResponse);
              if (response.statusCode == 201) {
              } else {}
            } catch (e) {
              // Exception occurred
            }
          }
        }
      } else {
        if (content != "") {
          try {
            socketService.sendMessage(inboxId, {
              'content': content,
              'senderId': Global.storageService.getUserId(),
              'parentMessageId': children?.id
            });
          } catch (error) {
            toastInfo(msg: 'Có lỗi trong việc gửi tin nhắn');
          }
        }
        if (images.length > 0) {
          var apiUrl = dotenv.env['API_URL'];
          var endpoint = '/messages/inbox/$inboxId/media';

          var token = Global.storageService.getUserAuthToken();

          var headers = <String, String>{
            'Authorization': 'Bearer $token',
            "Content-Type": "application/json"
            // Include bearer token in the headers
          };

          for (int i = 0; i < images.length; i++) {
            var request =
                http.MultipartRequest('POST', Uri.parse('$apiUrl$endpoint'));
            request.headers.addAll(headers);
            request.fields['messageType'] = 'IMAGE';
            request.fields['parentMessageId'] = children!.id.toString();

            File imageFile = await resizeImageIfNeeded(images[i]);

            request.files.add(
              http.MultipartFile(
                'media',
                imageFile.readAsBytes().asStream(),
                imageFile.lengthSync(),
                filename: imageFile.toString(),
                contentType: MediaType('image', 'jpeg'),
              ),
            );

            try {
              // Send the request
              var streamedResponse = await request.send();

              // Convert the streamed response to a regular HTTP response
              var response = await http.Response.fromStream(streamedResponse);
              if (response.statusCode == 201) {
              } else {}
            } catch (e) {
              // Exception occurred
            }
          }
        }
      }
      context.read<ChatDetailBloc>().add(IsLoadingEvent(false));
      hideLoadingIndicator();
      context.read<ChatDetailBloc>().add(ModeEvent(0));
      context.read<ChatDetailBloc>().add(ContentEvent(''));
      context.read<ChatDetailBloc>().add(ImagesEvent([]));
      context.read<ChatDetailBloc>().add(ModeImageEvent(false));
    } catch (error) {
      hideLoadingIndicator();
    }
  }

  Future<void> handleReceiveMessage(String message) async {
    Map<String, dynamic> json = jsonDecode(message);
    var response = Message.fromJson(json["message"]);
    List<Message> currentList =
        BlocProvider.of<ChatDetailBloc>(context).state.messages;

    // Create a new list by adding newsResponse.news to the existing list
    List<Message> updatedNewsList = List.of(currentList)..insert(0, response);

    context.read<ChatDetailBloc>().add(MessagesEvent(updatedNewsList));
  }

  Future<void> handleReplyMessage(Message message) async {
    context.read<ChatDetailBloc>().add(ModeEvent(1));
    context.read<ChatDetailBloc>().add(ChildrenEvent(message));
  }
}
