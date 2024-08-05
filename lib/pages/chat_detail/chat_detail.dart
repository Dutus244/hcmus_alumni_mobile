import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hcmus_alumni_mobile/pages/chat_detail/bloc/chat_detail_events.dart';
import '../../common/services/socket_service.dart';
import '../../common/values/colors.dart';
import 'bloc/chat_detail_blocs.dart';
import 'bloc/chat_detail_states.dart';
import 'chat_detail_controller.dart';
import 'widgets/chat_detail_widget.dart';

class ChatDetail extends StatefulWidget {
  const ChatDetail({super.key});

  @override
  State<ChatDetail> createState() => _ChatDetailState();
}

class _ChatDetailState extends State<ChatDetail> {
  final _scrollController = ScrollController();
  bool _isFetchingData = false;
  final _scrollControllerDeviceImage = ScrollController();
  bool _isFetchingDataDeviceImage = false;
  int inboxId = 0;
  String name = "";

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _scrollControllerDeviceImage.addListener(_onScrollDeviceImage);
    context.read<ChatDetailBloc>().add(ChatDetailResetEvent());
    context.read<ChatDetailBloc>().add(IsLoadingEvent(false));
    ChatDetailController(context: context).handleLoadDeviceImages(0);
    socketService.messages.listen((message) {
      ChatDetailController(context: context).handleReceiveMessage(message);
    });
  }

  void _onScroll() {
    final minScroll = _scrollController.position.minScrollExtent;
    final currentScroll = _scrollController.offset;
    if (currentScroll >= (minScroll + 90) && !_isFetchingData) {
      // Kiểm tra nếu cuộn gần đến đầu danh sách
      _isFetchingData = true;
      Timer(Duration(seconds: 1), () {
        _isFetchingData = false;
      });

      ChatDetailController(context: context).handleLoadMessageData(
          BlocProvider.of<ChatDetailBloc>(context).state.indexMessage, inboxId);
    }
  }

  void _onScrollDeviceImage() {
    final maxScroll = _scrollControllerDeviceImage.position.maxScrollExtent;
    final currentScroll = _scrollControllerDeviceImage.offset;
    if (currentScroll >= (maxScroll * 0.9) && !_isFetchingDataDeviceImage) {
      _isFetchingDataDeviceImage = true;
      Timer(Duration(seconds: 1), () {
        _isFetchingDataDeviceImage = false;
      });

      ChatDetailController(context: context).handleLoadDeviceImages(
          BlocProvider.of<ChatDetailBloc>(context).state.indexDeviceImage);
    }
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic>? args =
    ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    if (args != null) {
      inboxId = args["inboxId"];
      name = args["name"];
      // Now you can use the passedValue in your widget
      ChatDetailController(context: context).handleLoadMessageData(0, inboxId);
    }

    return BlocBuilder<ChatDetailBloc, ChatDetailState>(
        builder: (context, state) {
      return Scaffold(
        appBar: buildAppBar(context, name),
        backgroundColor: AppColors.background,
        body: listMessage(context, _scrollController, _scrollControllerDeviceImage, inboxId),
      );
    });
  }
}
