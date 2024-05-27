import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/values/colors.dart';
import '../../model/group.dart';
import 'bloc/group_edit_blocs.dart';
import 'bloc/group_edit_events.dart';
import 'bloc/group_edit_states.dart';
import 'widgets/group_edit_widget.dart';

class GroupEdit extends StatefulWidget {
  const GroupEdit({super.key});

  @override
  State<GroupEdit> createState() => _GroupEditState();
}

class _GroupEditState extends State<GroupEdit> {
  late int secondRoute;
  late Group group;

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic>? args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    if (args != null) {
      group = args["group"];
      secondRoute = args["secondRoute"];
      context.read<GroupEditBloc>().add(GroupEditResetEvent());
      context.read<GroupEditBloc>().add(NameEvent(group.name));
      context.read<GroupEditBloc>().add(DescriptionEvent(group.description));
      context.read<GroupEditBloc>().add(PrivacyEvent(group.privacy == 'PUBLIC' ? 0 : 1));
      context.read<GroupEditBloc>().add(NetworkPictureEvent(group.coverUrl ?? ''));
    }

    return PopScope(
        canPop: false, // prevent back
        onPopInvoked: (_) async {
          Navigator.of(context).pushNamedAndRemoveUntil(
            "/groupManagement",
            (route) => false,
            arguments: {
              "group": group,
              "secondRoute": secondRoute,
            },
          );
        },
        child: BlocBuilder<GroupEditBloc, GroupEditState>(
            builder: (context, state) {
          return Scaffold(
              appBar: buildAppBar(context, group, secondRoute),
              backgroundColor: AppColors.primaryBackground,
              body: groupEdit(context, group, secondRoute));
        }));
  }
}
