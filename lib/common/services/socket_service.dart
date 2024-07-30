import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:stomp_dart_client/stomp_dart_client.dart';

class SocketService extends WidgetsBindingObserver {
  StompClient? stompClient;
  final StreamController<String> _messageController =
      StreamController<String>.broadcast();

  Stream<String> get messages => _messageController.stream;

  void connect(String userId) {
    stompClient = StompClient(
      config: StompConfig.sockJS(
        url: dotenv.env['SOCKET_URL'] ?? '',
        onConnect: (StompFrame frame) {
          print('Connected to socket');
          stompClient?.subscribe(
            destination: '/user/$userId/queue/messages',
            callback: (StompFrame frame) {
              if (frame.body != null) {
                _messageController
                    .add(frame.body!); // Gửi tin nhắn mới vào stream
              }
            },
          );
        },
        onWebSocketError: (dynamic error) => print('WebSocket Error: $error'),
      ),
    );

    stompClient?.activate();
    WidgetsBinding.instance.addObserver(this);
  }

  void disconnect() {
    stompClient?.deactivate();
    WidgetsBinding.instance.removeObserver(this);
    _messageController.close(); // Đóng stream khi ngắt kết nối
  }

  void sendMessage(int inboxId, Map<String, dynamic> message) {
    String body = jsonEncode(message); // Chuyển đổi Map thành chuỗi JSON
    stompClient?.send(
      destination: '/app/send-message/$inboxId',
      body: body,
    );
  }

  void readInbox(int inboxId, Map<String, dynamic> message) {
    String body = jsonEncode(message); // Chuyển đổi Map thành chuỗi JSON
    stompClient?.send(
      destination: '/app/read-inbox/$inboxId',
      body: body,
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.detached) {
      disconnect();
    }
  }
}

final socketService = SocketService();
