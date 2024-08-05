import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/values/colors.dart';
import 'bloc/friend_list_blocs.dart';
import 'bloc/friend_list_states.dart';
import 'bloc/friend_list_events.dart';
import 'friend_list_controller.dart';
import 'widgets/friend_list_widget.dart';

class FriendList extends StatefulWidget {
  const FriendList({super.key});

  @override
  State<FriendList> createState() => _FriendListState();
}

class _FriendListState extends State<FriendList> {
  final _scrollController = ScrollController();
  bool _isFetchingData = false;
  String id = "";

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    context.read<FriendListBloc>().add(NameEvent(''));
    context.read<FriendListBloc>().add(NameSearchEvent(''));
    context.read<FriendListBloc>().add(ClearResultEvent());
    context.read<FriendListBloc>().add(IsLoadingEvent(false));
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    if (currentScroll >= (maxScroll * 0.9) && !_isFetchingData) {
      _isFetchingData = true;
      Timer(Duration(seconds: 1), () {
        _isFetchingData = false;
      });

      FriendListController(context: context).handleLoadFriendData(
          BlocProvider.of<FriendListBloc>(context).state.indexFriend, id);
    }
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic>? args =
    ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    if (args != null) {
      id = args["id"];
      FriendListController(context: context).handleLoadFriendData(0, id);
      FriendListController(context: context).handleGetFriendCount(id);
    }

    return BlocBuilder<FriendListBloc, FriendListState>(builder: (context, state) {
      return Scaffold(
        appBar: buildAppBar(context),
        backgroundColor: AppColors.background,
        body: listFriend(context, _scrollController, id),
      );
    });
  }
}
