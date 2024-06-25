import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hcmus_alumni_mobile/pages/group_member_approve/group_member_approve_controller.dart';

import '../../common/values/colors.dart';
import '../../model/group.dart';
import 'bloc/group_member_approve_blocs.dart';
import 'bloc/group_member_approve_states.dart';
import 'widgets/group_member_approve_widget.dart';

class GroupMemberApprove extends StatefulWidget {
  const GroupMemberApprove({super.key});

  @override
  State<GroupMemberApprove> createState() => _GroupMemberApproveState();
}

class _GroupMemberApproveState extends State<GroupMemberApprove> {
  final _scrollController = ScrollController();
  bool _isFetchingData = false;
  late Group group;

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
    }
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic>? args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    if (args != null) {
      group = args["group"];
      GroupMemberApproveController(context: context)
          .handleGetMember(group.id, 0);
    }

    return BlocBuilder<GroupMemberApproveBloc, GroupMemberApproveState>(
        builder: (context, state) {
          return Scaffold(
              appBar: buildAppBar(context),
              backgroundColor: AppColors.background,
              body: listRequest(context, _scrollController, group.id));
        });
  }
}
