import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:hcmus_alumni_mobile/pages/notification_page/bloc/notification_page_blocs.dart';
import 'package:hcmus_alumni_mobile/pages/notification_page/widgets/notification_page_widget.dart';

import '../../common/values/colors.dart';
import '../../common/widgets/app_bar.dart';
import 'bloc/notification_page_states.dart';
import 'notification_page_controller.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final _scrollController = ScrollController();
  bool _isFetchingData = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    NotificationPageController(context: context).handleLoadNotificationsData(0);
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    if (currentScroll >= (maxScroll * 0.9) && !_isFetchingData) {
      _isFetchingData = true;
      Timer(Duration(seconds: 1), () {
        _isFetchingData = false;
      });
      NotificationPageController(context: context).handleLoadNotificationsData(BlocProvider.of<NotificationPageBloc>(context).state.indexNotification);
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
      child: BlocBuilder<NotificationPageBloc, NotificationPageState>(
          builder: (context, state) {
            return Container(
              child: Scaffold(
                appBar: buildAppBar(context, translate('notification')),
                backgroundColor: AppColors.background,
                body: listNotifications(context, _scrollController),
              ),
            );
          }),
    );
  }
}
