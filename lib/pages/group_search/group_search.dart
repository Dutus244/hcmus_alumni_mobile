import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hcmus_alumni_mobile/pages/group_search/bloc/group_search_events.dart';

import '../../common/values/colors.dart';
import 'bloc/group_search_blocs.dart';
import 'bloc/group_search_states.dart';
import 'group_search_controller.dart';
import 'widgets/group_search_widget.dart';

class GroupSearch extends StatefulWidget {
  const GroupSearch({super.key});

  @override
  State<GroupSearch> createState() => _GroupSearchState();
}

class _GroupSearchState extends State<GroupSearch> {
  late PageController pageController; // Không khởi tạo ở đây
  final _scrollController = ScrollController();
  bool _isFetchingData = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    context.read<GroupSearchBloc>().add(NameEvent(''));
    context.read<GroupSearchBloc>().add(NameSearchEvent(''));
    context.read<GroupSearchBloc>().add(ClearResultEvent());
    GroupSearchController(context: context).handleLoadGroupData(0);
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    if (currentScroll >= (maxScroll * 0.9) && !_isFetchingData) {
      _isFetchingData = true;
      Timer(Duration(seconds: 1), () {
        _isFetchingData = false;
      });

      GroupSearchController(context: context).handleLoadGroupData(
          BlocProvider.of<GroupSearchBloc>(context).state.indexGroup);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GroupSearchBloc, GroupSearchState>(builder: (context, state) {
      return Scaffold(
        appBar: buildAppBar(context),
        backgroundColor: AppColors.background,
        body: listGroup(context, _scrollController),
      );
    });
  }
}
