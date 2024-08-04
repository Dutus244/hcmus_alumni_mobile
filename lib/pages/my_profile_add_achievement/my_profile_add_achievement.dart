import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hcmus_alumni_mobile/model/achievement.dart';
import '../../common/values/colors.dart';
import '../../model/job.dart';
import 'bloc/my_profile_add_achievement_blocs.dart';
import 'bloc/my_profile_add_achievement_events.dart';
import 'bloc/my_profile_add_achievement_states.dart';
import 'widgets/my_profile_add_achievement_widget.dart';

class MyProfileAddAchievement extends StatefulWidget {
  const MyProfileAddAchievement({super.key});

  @override
  State<MyProfileAddAchievement> createState() => _MyProfileAddAchievementState();
}

class _MyProfileAddAchievementState extends State<MyProfileAddAchievement> {
  int option = 0;
  Achievement? achievement;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      handleNavigation();
    });
  }

  void handleNavigation() {
    Map<String, dynamic>? args =
    ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    if (args != null) {
      option = args["option"];
      context.read<MyProfileAddAchievementBloc>().add(IsLoadingEvent(false));
      if (option == 1) {
        achievement = args["achievement"];
        context.read<MyProfileAddAchievementBloc>().add(NameEvent(achievement!.name));
        context.read<MyProfileAddAchievementBloc>().add(TypeEvent(achievement!.type));
        context.read<MyProfileAddAchievementBloc>().add(TimeEvent(achievement!.time));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyProfileAddAchievementBloc, MyProfileAddAchievementState>(
        builder: (context, state) {
          return Scaffold(
              appBar: buildAppBar(context),
              backgroundColor: AppColors.background,
              body: myProfileAddAchievement(context, option, achievement != null ? achievement!.id : ''));
        });
  }
}
