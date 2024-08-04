import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:hcmus_alumni_mobile/pages/friend_page/widgets/friend_page_widget.dart';

import '../../common/values/colors.dart';
import '../../common/widgets/app_bar.dart';
import 'bloc/friend_page_blocs.dart';
import 'bloc/friend_page_events.dart';
import 'bloc/friend_page_states.dart';
import 'friend_page_controller.dart';

class FriendPage extends StatefulWidget {
  const FriendPage({super.key});

  @override
  State<FriendPage> createState() => _FriendPageState();
}

class _FriendPageState extends State<FriendPage> {
  final _scrollController = ScrollController();
  bool _isFetchingData = false;

  @override
  void initState() {
    super.initState();
    // Khởi tạo pageController trong initState
    _scrollController.addListener(_onScroll);
    FriendPageController(context: context).handleLoadUserData(0);
    FriendPageController(context: context).handleLoadSuggestionData(0);
    FriendPageController(context: context).handleLoadRequestData(0);
    context.read<FriendPageBloc>().add(NameEvent(''));
    context.read<FriendPageBloc>().add(NameSearchEvent(''));
    context.read<FriendPageBloc>().add(IsLoadingEvent(false));
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    if (currentScroll >= (maxScroll * 0.9) && !_isFetchingData) {
      _isFetchingData = true;
      Timer(Duration(seconds: 1), () {
        _isFetchingData = false;
      });

      if (BlocProvider.of<FriendPageBloc>(context).state.page == 0) {
        FriendPageController(context: context).handleLoadUserData(
            BlocProvider.of<FriendPageBloc>(context).state.indexUser);
      } else  if (BlocProvider.of<FriendPageBloc>(context).state.page == 1) {
        FriendPageController(context: context).handleLoadSuggestionData(
            BlocProvider.of<FriendPageBloc>(context).state.indexSuggestion);
      } else if (BlocProvider.of<FriendPageBloc>(context).state.page == 2) {
        FriendPageController(context: context).handleLoadRequestData(
            BlocProvider.of<FriendPageBloc>(context).state.indexRequest);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false, // prevent back
      onPopInvoked: (_) async {
        final shouldExit = await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(translate('exit_application')),
            content: Text(translate('exit_application_question')),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: Text(translate('cancel')),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: Text(translate('exit')),
              ),
            ],
          ),
        );
        if (shouldExit) {
          SystemNavigator.pop();
        }
        return shouldExit ?? false;
      },
      child: BlocBuilder<FriendPageBloc, FriendPageState>(
          builder: (context, state) {
            Widget body;
            switch (state.page) {
              case 0:
                body = listUser(context, _scrollController);
                break;
              case 1:
                body = listSuggestion(context, _scrollController);
                break;
              case 2:
                body = listRequest(context, _scrollController);
                break;
              default:
                body = Center(child: Text('Page not found'));
            }

            return Container(
              child: Scaffold(
                appBar: buildAppBar(context, translate('friend')),
                backgroundColor: AppColors.background,
                body: body,
              ),
            );
          }),
    );
  }
}
