import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hcmus_alumni_mobile/pages/group_edit/group_edit_controller.dart';

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
  Group? group;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      handleNavigation();
    });
    context.read<GroupEditBloc>().add(IsLoadingEvent(false));
    context.read<GroupEditBloc>().add(PicturesEvent([]));
  }

  void handleNavigation() {
    Map<String, dynamic>? args =
    ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    if (args != null) {
      group = args["group"];
      GroupEditController(context: context).handleGetGroup(group!.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GroupEditBloc, GroupEditState>(
        builder: (context, state) {
          return Scaffold(
              appBar: buildAppBar(context),
              backgroundColor: AppColors.background,
              body: groupEdit(context, group));
        });
  }
}
