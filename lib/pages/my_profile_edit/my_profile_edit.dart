import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hcmus_alumni_mobile/pages/my_profile_edit/bloc/my_profile_edit_events.dart';
import 'package:hcmus_alumni_mobile/pages/my_profile_edit/my_profile_edit_controller.dart';

import '../../common/values/colors.dart';
import 'bloc/my_profile_edit_blocs.dart';
import 'bloc/my_profile_edit_states.dart';
import 'widgets/my_profile_edit_widget.dart';

class MyProfileEdit extends StatefulWidget {
  const MyProfileEdit({super.key});

  @override
  State<MyProfileEdit> createState() => _MyProfileEditState();
}

class _MyProfileEditState extends State<MyProfileEdit> {
  @override
  void initState() {
    super.initState();
    MyProfileEditController(context: context).handleGetProfile();
    MyProfileEditController(context: context).handleGetJob();
    MyProfileEditController(context: context).handleGetEducation();
    MyProfileEditController(context: context).handleGetAchievement();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyProfileEditBloc, MyProfileEditState>(
      builder: (context, state) {
        return WillPopScope(
          onWillPop: () async {
            return !state.isLoading;
          },
          child: Scaffold(
              appBar: buildAppBar(context),
              backgroundColor: AppColors.background,
              body: myProfileEdit(context, state.user)
          ),
        );
      },
    );
  }
}
