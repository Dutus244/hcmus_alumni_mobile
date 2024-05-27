import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hcmus_alumni_mobile/pages/group_member/bloc/group_member_blocs.dart';
import 'package:hcmus_alumni_mobile/pages/group_member/bloc/group_member_states.dart';
import 'package:hcmus_alumni_mobile/pages/group_member/group_member_controller.dart';
import 'package:hcmus_alumni_mobile/pages/group_member/widgets/group_member_widget.dart';

import '../../common/values/colors.dart';
import '../../model/group.dart';

class GroupMember extends StatefulWidget {
  const GroupMember({super.key});

  @override
  State<GroupMember> createState() => _GroupMemberState();
}

class _GroupMemberState extends State<GroupMember> {
  late int secondRoute;
  late Group group;
  late int route;
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

      if (!BlocProvider.of<GroupMemberBloc>(context).state.hasReachedMaxAdmin) {
        GroupMemberController(context: context).handleGetAdmin(group.id,
            BlocProvider.of<GroupMemberBloc>(context).state.indexAdmin);
      } else {
        GroupMemberController(context: context).handleGetMember(group.id,
            BlocProvider.of<GroupMemberBloc>(context).state.indexMember);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic>? args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    if (args != null) {
      group = args["group"];
      secondRoute = args["secondRoute"];
      route = args["route"];
      GroupMemberController(context: context).handleGetAdmin(group.id, 0);
    }
    return PopScope(
      canPop: false, // prevent back
      onPopInvoked: (_) async {
        if (route == 0) {
          Navigator.of(context).pushNamedAndRemoveUntil(
            "/groupInfo",
                (route) => false,
            arguments: {
              "group": group,
              "secondRoute": secondRoute,
            },
          );
        }
        else {
          Navigator.of(context).pushNamedAndRemoveUntil(
            "/groupManagement",
                (route) => false,
            arguments: {
              "group": group,
              "secondRoute": secondRoute,
            },
          );
        }
      },
      child: BlocBuilder<GroupMemberBloc, GroupMemberState>(
          builder: (context, state) {
        return Scaffold(
          appBar: buildAppBar(context, group, secondRoute, route),
          backgroundColor: AppColors.primaryBackground,
          body: listMember(context, _scrollController, group, secondRoute),
        );
      }),
    );
  }
}
