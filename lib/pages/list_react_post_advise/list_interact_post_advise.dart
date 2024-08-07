import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hcmus_alumni_mobile/pages/list_react_post_advise/widgets/list_interact_post_advise_widget.dart';

import '../../common/values/colors.dart';
import 'bloc/list_interact_post_advise_blocs.dart';
import 'bloc/list_interact_post_advise_states.dart';
import 'list_interact_post_advise_controller.dart';

class ListInteractPostAdvise extends StatefulWidget {
  const ListInteractPostAdvise({super.key});

  @override
  State<ListInteractPostAdvise> createState() => _ListInteractPostAdviseState();
}

class _ListInteractPostAdviseState extends State<ListInteractPostAdvise> {
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

      ListInteractPostAdviseController(context: context).handleGetListInteract(
          id,
          BlocProvider.of<ListInteractPostAdviseBloc>(context)
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
      ListInteractPostAdviseController(context: context)
          .handleGetListInteract(id, 0);
    }

    return BlocBuilder<ListInteractPostAdviseBloc, ListInteractPostAdviseState>(
        builder: (context, state) {
          return Scaffold(
            appBar: buildAppBar(context),
            backgroundColor: AppColors.background,
            body: listInteract(context, _scrollController),
          );
        });
  }
}
