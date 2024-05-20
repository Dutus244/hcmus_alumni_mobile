import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'widgets/list_interact_post_group_widget.dart';

import '../../common/values/colors.dart';
import 'bloc/list_interact_post_group_blocs.dart';
import 'bloc/list_interact_post_group_states.dart';
import 'list_interact_post_group_controller.dart';

class ListInteractPostGroup extends StatefulWidget {
  const ListInteractPostGroup({super.key});

  @override
  State<ListInteractPostGroup> createState() => _ListInteractPostGroupState();
}

class _ListInteractPostGroupState extends State<ListInteractPostGroup> {
  late String id;
  late String groupId;
  late int secondRoute;
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

      ListInteractPostGroupController(context: context).handleGetListInteract(
          id,
          BlocProvider.of<ListInteractPostGroupBloc>(context)
              .state
              .indexInteract);
    }
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic>? args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    if (args != null) {
      id = args["id"];
      groupId = args["groupId"];
      secondRoute = args["secondRoute"];
      ListInteractPostGroupController(context: context)
          .handleGetListInteract(id, 0);
    }

    return PopScope(
      canPop: false, // prevent back
      onPopInvoked: (_) async {
        Navigator.of(context).pushNamedAndRemoveUntil(
          "/groupDetail",
              (route) => false,
          arguments: {
            "id": groupId,
            "secondRoute": secondRoute,
          },
        );
      },
      child:
          BlocBuilder<ListInteractPostGroupBloc, ListInteractPostGroupState>(
              builder: (context, state) {
        return Scaffold(
          appBar: buildAppBar(context, groupId, secondRoute),
          backgroundColor: AppColors.primaryBackground,
          body: listInteract(context, _scrollController),
        );
      }),
    );
  }
}
