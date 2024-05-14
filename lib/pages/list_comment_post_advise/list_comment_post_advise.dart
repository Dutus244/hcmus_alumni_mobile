import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hcmus_alumni_mobile/model/creator.dart';
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

    return PopScope(
      canPop: false, // prevent back
      onPopInvoked: (_) async {
        Navigator.of(context).pushNamedAndRemoveUntil(
            "/applicationPage", (route) => false,
            arguments: {"route": 2, "secondRoute": 0});
      },
      child: BlocBuilder<ListCommentPostAdviseBloc, ListCommentPostAdviseState>(
          builder: (context, state) {
        return Scaffold(
          appBar: buildAppBar(() {
            Navigator.of(context).pushNamedAndRemoveUntil(
                "/applicationPage", (route) => false,
                arguments: {"route": 2, "secondRoute": 0});
          }),
          backgroundColor: AppColors.primaryBackground,
          body: listComment(
              context,
              _scrollController,
              BlocProvider.of<ListCommentPostAdviseBloc>(context).state.content,
              BlocProvider.of<ListCommentPostAdviseBloc>(context)
                  .state
                  .children,
              id, (value) {
            context.read<ListCommentPostAdviseBloc>().add(ContentEvent(value));
          }, () {
            ListCommentPostAdviseController(context: context)
                .handleLoadWriteComment(id);
          }, () {
            ListCommentPostAdviseController(context: context)
                .handleLoadWriteChildrenComment(
                    id,
                    BlocProvider.of<ListCommentPostAdviseBloc>(context)
                        .state
                        .children!
                        .id);
          }, () {
            context.read<ListCommentPostAdviseBloc>().add(ReplyEvent(0));
            context.read<ListCommentPostAdviseBloc>().add(
                ChildrenEvent(Comment('', Creator('', '', ''), '', 0, '', '')));
          }, () {
            ListCommentPostAdviseController(context: context).handleEditComment(
                id,
                BlocProvider.of<ListCommentPostAdviseBloc>(context)
                    .state
                    .children!
                    .id);
          }),
        );
      }),
    );
  }
}
