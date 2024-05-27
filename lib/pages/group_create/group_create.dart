import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hcmus_alumni_mobile/pages/group_create/widgets/group_create_widget.dart';

import '../../common/values/colors.dart';
import 'bloc/group_create_blocs.dart';
import 'bloc/group_create_events.dart';
import 'bloc/group_create_states.dart';

class GroupCreate extends StatefulWidget {
  const GroupCreate({super.key});

  @override
  State<GroupCreate> createState() => _WritePostAdviseState();
}

class _WritePostAdviseState extends State<GroupCreate> {
  @override
  Widget build(BuildContext context) {
    var route;
    Map<String, dynamic>? args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    if (args != null) {
      route = args["route"];
      context.read<GroupCreateBloc>().add(GroupCreateResetEvent());
      // Now you can use the passedValue in your widget
    }

    return PopScope(
        canPop: false, // prevent back
        onPopInvoked: (_) async {
          Navigator.of(context).pushNamedAndRemoveUntil(
            "/applicationPage",
            (route) => false,
            arguments: {
              "route": route,
              "secondRoute": 0,
            },
          );
        },
        child: BlocBuilder<GroupCreateBloc, GroupCreateState>(
            builder: (context, state) {
          return Scaffold(
              appBar: buildAppBar(context, route),
              backgroundColor: AppColors.primaryBackground,
              body: groupCreate(context, route));
        }));
  }
}
