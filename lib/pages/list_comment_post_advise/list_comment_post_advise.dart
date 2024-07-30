import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hcmus_alumni_mobile/model/permissions.dart';
import 'package:hcmus_alumni_mobile/pages/list_comment_post_advise/widgets/list_comment_post_advise_widget.dart';

import '../../common/values/colors.dart';
import '../../model/comment.dart';
import 'bloc/list_comment_post_advise_blocs.dart';
import 'bloc/list_comment_post_advise_states.dart';
import 'bloc/list_comment_post_advise_events.dart';
import 'list_comment_post_advise_controller.dart';

class ListCommentPostAdvise extends StatefulWidget {
  const ListCommentPostAdvise({super.key});

  @override
  State<ListCommentPostAdvise> createState() => _ListCommentPostAdviseState();
}

class _ListCommentPostAdviseState extends State<ListCommentPostAdvise> {
  late String id;
  late PageController pageController; // Không khởi tạo ở đây
  final _scrollController = ScrollController();
  bool _isFetchingData = false;

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
          BlocProvider.of<ListCommentPostAdviseBloc>(context)
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
      ListCommentPostAdviseController(context: context).handleGetComment(id, 0);
    }

    return BlocBuilder<ListCommentPostAdviseBloc, ListCommentPostAdviseState>(
        builder: (context, state) {
          return Scaffold(
            appBar: buildAppBar(context),
            backgroundColor: AppColors.background,
            body: listComment(context, _scrollController, id),
          );
        });
  }
}
