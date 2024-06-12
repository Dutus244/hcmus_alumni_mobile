import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hcmus_alumni_mobile/pages/group_management/group_management_controller.dart';
import 'package:hcmus_alumni_mobile/pages/group_management/widgets/group_management_widget.dart';

import '../../common/values/colors.dart';
import '../../model/group.dart';
import 'bloc/group_management_blocs.dart';
import 'bloc/group_management_states.dart';

class GroupManagement extends StatefulWidget {
  const GroupManagement({super.key});

  @override
  State<GroupManagement> createState() => _GroupManagementState();
}

class _GroupManagementState extends State<GroupManagement> {
  late Group group;

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic>? args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    if (args != null) {
      group = args["group"];
      GroupManagementController(context: context).handleGetGroup(group.id);
    }

    return BlocBuilder<GroupManagementBloc, GroupManagementState>(
        builder: (context, state) {
          return Scaffold(
            appBar: buildAppBar(context),
            backgroundColor: AppColors.primaryBackground,
            body: groupManagement(context, state.group),
          );
        });
  }
}
