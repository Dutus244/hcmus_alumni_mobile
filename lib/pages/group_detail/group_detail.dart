import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hcmus_alumni_mobile/pages/group_detail/group_detail_controller.dart';
import 'package:hcmus_alumni_mobile/pages/group_detail/widgets/group_detail_widget.dart';

import '../../common/values/colors.dart';
import 'bloc/group_detail_blocs.dart';
import 'bloc/group_detail_states.dart';

class GroupDetail extends StatefulWidget {
  const GroupDetail({super.key});

  @override
  State<GroupDetail> createState() => _GroupDetailState();
}

class _GroupDetailState extends State<GroupDetail> {
  late PageController pageController; // Không khởi tạo ở đây
  final _scrollController = ScrollController();
  bool _isFetchingData = false;
  late String id;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    if (currentScroll >= (maxScroll * 0.9) && !_isFetchingData) {
      _isFetchingData = true;
      Timer(Duration(seconds: 1), () {
        _isFetchingData = false;
      });

      GroupDetailController(context: context).handleLoadPostData(id,
          BlocProvider.of<GroupDetailBloc>(context).state.indexPost);
    }
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic>? args =
    ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    if (args != null) {
      id = args["id"];
      GroupDetailController(context: context).handleGetGroup(id);
    }

    return BlocBuilder<GroupDetailBloc, GroupDetailState>(
        builder: (context, state) {
          if (state.group != null && state.group!.privacy == "PRIVATE" && !state.group!.isJoined) {
            return Scaffold(
              appBar: buildAppBar(context),
              backgroundColor: AppColors.primaryBackground,
              body: groupPrivateNotJoined(context, state.group),
            );
          }
          else {
            return Scaffold(
                appBar: buildAppBar(context),
                backgroundColor: AppColors.primaryBackground,
                body: group(context, _scrollController, state.group)
            );
          }
        });
  }
}