import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../common/values/colors.dart';
import '../../model/job.dart';
import 'bloc/my_profile_add_job_blocs.dart';
import 'bloc/my_profile_add_job_events.dart';
import 'bloc/my_profile_add_job_states.dart';
import 'widgets/my_profile_add_job_widget.dart';

class MyProfileAddJob extends StatefulWidget {
  const MyProfileAddJob({super.key});

  @override
  State<MyProfileAddJob> createState() => _MyProfileAddJobState();
}

class _MyProfileAddJobState extends State<MyProfileAddJob> {
  int option = 0;
  Job? job;

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
      context.read<MyProfileAddJobBloc>().add(MyProfileAddJobResetEvent());
      context.read<MyProfileAddJobBloc>().add(IsLoadingEvent(false));
      if (option == 1) {
        job = args["job"];
        context.read<MyProfileAddJobBloc>().add(CompanyNameEvent(job!.companyName));
        context.read<MyProfileAddJobBloc>().add(PositionEvent(job!.position));
        context.read<MyProfileAddJobBloc>().add(StartTimeEvent(job!.startTime));
        context.read<MyProfileAddJobBloc>().add(EndTimeEvent(job!.endTime));
        context.read<MyProfileAddJobBloc>().add(IsWorkingEvent(job!.isWorking));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyProfileAddJobBloc, MyProfileAddJobState>(
        builder: (context, state) {
          return Scaffold(
              appBar: buildAppBar(context),
              backgroundColor: AppColors.background,
              body: myProfileAddJob(context, option, job != null ? job!.id : ''));
        });
  }
}
