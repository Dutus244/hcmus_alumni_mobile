import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:hcmus_alumni_mobile/pages/advise_page/widgets/advise_page_widget.dart';

import '../../common/values/colors.dart';
import 'advise_page_controller.dart';
import 'bloc/advise_page_blocs.dart';
import 'bloc/advise_page_states.dart';
import 'dart:io' show Platform, exit;

class AdvisePage extends StatefulWidget {
  const AdvisePage({super.key});

  @override
  State<AdvisePage> createState() => _AdvisePageState();
}

class _AdvisePageState extends State<AdvisePage> {
  late PageController pageController; // Không khởi tạo ở đây
  final _scrollController = ScrollController();
  bool _isFetchingData = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    AdvisePageController(context: context).handleLoadPostData(0);
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    if (currentScroll >= (maxScroll * 0.9) && !_isFetchingData) {
      _isFetchingData = true;
      Timer(Duration(seconds: 1), () {
        _isFetchingData = false;
      });

      AdvisePageController(context: context).handleLoadPostData(
          BlocProvider.of<AdvisePageBloc>(context).state.indexPost);
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
          if (Platform.isAndroid) {
            SystemNavigator.pop();
          } else if (Platform.isIOS) {
            exit(0);
          }
        }
        return shouldExit ?? false;
      },
      child: BlocBuilder<AdvisePageBloc, AdvisePageState>(
          builder: (context, state) {
        return Scaffold(
          appBar: buildAppBar(context),
          backgroundColor: AppColors.background,
          body: listPost(context, _scrollController),
        );
      }),
    );
  }
}
