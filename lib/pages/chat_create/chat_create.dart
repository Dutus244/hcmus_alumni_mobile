import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/values/colors.dart';
import 'bloc/chat_create_blocs.dart';
import 'bloc/chat_create_events.dart';
import 'bloc/chat_create_states.dart';
import 'chat_create_controller.dart';
import 'widgets/chat_create_widget.dart';

class ChatCreate extends StatefulWidget {
  const ChatCreate({super.key});

  @override
  State<ChatCreate> createState() => _FriendListState();
}

class _FriendListState extends State<ChatCreate> {
  final _scrollController = ScrollController();
  bool _isFetchingData = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    context.read<ChatCreateBloc>().add(NameEvent(''));
    context.read<ChatCreateBloc>().add(NameSearchEvent(''));
    ChatCreateController(context: context).handleLoadUserData(0);
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    if (currentScroll >= (maxScroll * 0.9) && !_isFetchingData) {
      _isFetchingData = true;
      Timer(Duration(seconds: 1), () {
        _isFetchingData = false;
      });

      ChatCreateController(context: context).handleLoadUserData(
          BlocProvider.of<ChatCreateBloc>(context).state.indexUser);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatCreateBloc, ChatCreateState>(builder: (context, state) {
      return Scaffold(
        appBar: buildAppBar(context),
        backgroundColor: AppColors.background,
        body: listUser(context, _scrollController),
      );
    });
  }
}