import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hcmus_alumni_mobile/model/creator.dart';
import 'package:hcmus_alumni_mobile/model/permissions.dart';
import 'widgets/list_comment_post_group_widget.dart';

import '../../common/values/colors.dart';
import '../../model/comment.dart';
import 'bloc/list_comment_post_group_blocs.dart';
import 'bloc/list_comment_post_group_states.dart';
import 'bloc/list_comment_post_group_events.dart';
import 'list_comment_post_group_controller.dart';

class ListCommentPostGroup extends StatefulWidget {
  const ListCommentPostGroup({super.key});

  @override
  State<ListCommentPostGroup> createState() => _ListCommentPostGroupState();
}

class _ListCommentPostGroupState extends State<ListCommentPostGroup> {
  late PageController pageController; // Không khởi tạo ở đây
  final _scrollController = ScrollController();
  bool _isFetchingData = false;
  late String id;
  late String groupId;

  @override
  void initState() {
    super.initState();
    // Khởi tạo pageController trong initState
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

      ListCommentPostAdviseController(context: context).handleGetComment(
          id,
          BlocProvider.of<ListCommentPostGroupBloc>(context)
              .state
              .indexComment);
    }
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic>? args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    if (args != null) {
      id = args["id"];
      groupId = args["groupId"];
      ListCommentPostAdviseController(context: context).handleGetComment(id, 0);
    }

    return BlocBuilder<ListCommentPostGroupBloc, ListCommentPostGroupState>(
        builder: (context, state) {
          return Scaffold(
            appBar: buildAppBar(context),
            backgroundColor: AppColors.primaryBackground,
            body: listComment(context, _scrollController, id, (value) {
              context.read<ListCommentPostGroupBloc>().add(ContentEvent(value));
            }),
          );
        });
  }
}
