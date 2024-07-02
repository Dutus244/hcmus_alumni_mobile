import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hcmus_alumni_mobile/pages/post_group_detail/post_group_detail_controller.dart';

import '../../common/values/colors.dart';
import 'bloc/post_group_detail_blocs.dart';
import 'bloc/post_group_detail_states.dart';
import 'widgets/post_group_detail_widget.dart';

class PostGroupDetail extends StatefulWidget {
  const PostGroupDetail({super.key});

  @override
  State<PostGroupDetail> createState() => _PostGroupDetailState();
}

class _PostGroupDetailState extends State<PostGroupDetail> {
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

      PostGroupDetailController(context: context).handleGetComment(
          id,
          BlocProvider.of<PostGroupDetailBloc>(context)
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
      PostGroupDetailController(context: context).handleLoadPostData(id);
      PostGroupDetailController(context: context).handleGetComment(id, 0);
    }

    return BlocBuilder<PostGroupDetailBloc, PostGroupDetailState>(
        builder: (context, state) {
          return Scaffold(
            appBar: buildAppBar(context),
            backgroundColor: AppColors.background,
            body: listComment(context, _scrollController, id),
          );
        });
  }
}
