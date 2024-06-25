import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hcmus_alumni_mobile/pages/group_info/group_info_controller.dart';

import '../../common/values/colors.dart';
import '../../model/group.dart';
import 'bloc/group_info_blocs.dart';
import 'bloc/group_info_states.dart';
import 'widget/group_info_widget.dart';

class GroupInfo extends StatefulWidget {
  const GroupInfo({super.key});

  @override
  State<GroupInfo> createState() => _GroupInfoState();
}

class _GroupInfoState extends State<GroupInfo> {
  late Group group;

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic>? args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    if (args != null) {
      group = args["group"];
      GroupInfoController(context: context).handleGetAdmin(group.id, 0);
      GroupInfoController(context: context).handleGetMember(group.id, 0);
    }

    return BlocBuilder<GroupInfoBloc, GroupInfoState>(
        builder: (context, state) {
          return Scaffold(
            appBar: buildAppBar(context, group),
            backgroundColor: AppColors.background,
            body: infoGroup(context, group),
          );}
    );
  }
}
