import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/services/socket_service.dart';
import '../../common/values/colors.dart';
import 'bloc/chat_page_blocs.dart';
import 'bloc/chat_page_states.dart';
import 'chat_page_controller.dart';
import 'widgets/chat_page_widget.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _scrollController = ScrollController();
  bool _isFetchingData = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    ChatPageController(context: context).handleLoadInboxData(0);
    socketService.messages.listen((message) {
      ChatPageController(context: context).handleLoadInboxData(0);
    });
  }

  @override
  void dispose() {
    socketService.disconnect();
    super.dispose();
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    if (currentScroll >= (maxScroll * 0.9) && !_isFetchingData) {
      _isFetchingData = true;
      Timer(Duration(seconds: 1), () {
        _isFetchingData = false;
      });

      ChatPageController(context: context).handleLoadInboxData(
          BlocProvider.of<ChatPageBloc>(context).state.indexInbox);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatPageBloc, ChatPageState>(builder: (context, state) {
      return Scaffold(
        appBar: buildAppBar(context),
        backgroundColor: AppColors.background,
        body: listInbox(context, _scrollController),
      );
    });
  }
}
