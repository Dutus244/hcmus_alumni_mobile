import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hcmus_alumni_mobile/pages/post_advise_detail/post_advise_detail_controller.dart';

import '../../common/values/colors.dart';
import 'bloc/post_advise_detail_blocs.dart';
import 'bloc/post_advise_detail_states.dart';
import 'bloc/post_advise_detail_events.dart';
import 'widgets/post_advise_detail_widget.dart';

class PostAdviseDetail extends StatefulWidget {
  const PostAdviseDetail({super.key});

  @override
  State<PostAdviseDetail> createState() => _PostAdviseDetailState();
}

class _PostAdviseDetailState extends State<PostAdviseDetail> {
  late String id;
  late PageController pageController; // Không khởi tạo ở đây
  final _scrollController = ScrollController();
  bool _isFetchingData = false;

  @override
  void initState() {
    super.initState();
    // Khởi tạo pageController trong initState
    _scrollController.addListener(_onScroll);
    context.read<PostAdviseDetailBloc>().add(IsLoadingEvent(false));
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    if (currentScroll >= (maxScroll * 0.9) && !_isFetchingData) {
      _isFetchingData = true;
      Timer(Duration(seconds: 1), () {
        _isFetchingData = false;
      });

      PostAdviseDetailController(context: context).handleGetComment(
          id,
          BlocProvider.of<PostAdviseDetailBloc>(context)
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
      PostAdviseDetailController(context: context).handleLoadPostData(id);
      PostAdviseDetailController(context: context).handleGetComment(id, 0);
    }

    return BlocBuilder<PostAdviseDetailBloc, PostAdviseDetailState>(
        builder: (context, state) {
          return Scaffold(
            appBar: buildAppBar(context),
            backgroundColor: AppColors.background,
            body: listComment(context, _scrollController, id),
          );
        });
  }
}
