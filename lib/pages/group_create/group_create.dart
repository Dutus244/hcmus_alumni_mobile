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
  void initState() {
    super.initState();
    context.read<GroupCreateBloc>().add(GroupCreateResetEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GroupCreateBloc, GroupCreateState>(
        builder: (context, state) {
          return Scaffold(
              appBar: buildAppBar(context),
              backgroundColor: AppColors.background,
              body: groupCreate(context));
        });
  }
}
