import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hcmus_alumni_mobile/model/education.dart';
import '../../common/values/colors.dart';
import '../../model/job.dart';
import 'bloc/my_profile_add_education_blocs.dart';
import 'bloc/my_profile_add_education_events.dart';
import 'bloc/my_profile_add_education_states.dart';
import 'widgets/my_profile_add_education_widget.dart';

class MyProfileAddEducation extends StatefulWidget {
  const MyProfileAddEducation({super.key});

  @override
  State<MyProfileAddEducation> createState() => _MyProfileAddEducationState();
}

class _MyProfileAddEducationState extends State<MyProfileAddEducation> {
  int option = 0;
  late Education education;
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic>? args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    if (args != null) {
      option = args["option"];
      context.read<MyProfileAddEducationBloc>().add(MyProfileAddEducationResetEvent());
      if (option == 1) {
        education = args["education"];
        context.read<MyProfileAddEducationBloc>().add(SchoolNameEvent(education.schoolName));
        context.read<MyProfileAddEducationBloc>().add(DegreeEvent(education.degree));
        context.read<MyProfileAddEducationBloc>().add(StartTimeEvent(education.startTime));
        context.read<MyProfileAddEducationBloc>().add(EndTimeEvent(education.endTime));
      }
    }

    return BlocBuilder<MyProfileAddEducationBloc, MyProfileAddEducationState>(
        builder: (context, state) {
          return Scaffold(
              appBar: buildAppBar(context),
              backgroundColor: AppColors.background,
              body: myProfileAddEducation(context));
        });
  }
}
