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
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic>? args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    var route = 0;
    var option = 0;
    late Job job;
    if (args != null) {
      route = args["route"];
      option = args["option"];
      context.read<MyProfileAddJobBloc>().add(MyProfileAddJobResetEvent());
      if (option == 1) {
        job = args["job"];
        context.read<MyProfileAddJobBloc>().add(CompanyNameEvent(job.companyName));
        context.read<MyProfileAddJobBloc>().add(PositionEvent(job.position));
        context.read<MyProfileAddJobBloc>().add(StartTimeEvent(job.startTime));
        context.read<MyProfileAddJobBloc>().add(EndTimeEvent(job.endTime));
      }
    }

    return PopScope(
      canPop: false, // prevent back
      onPopInvoked: (_) async {
        Navigator.of(context).pushNamedAndRemoveUntil(
            "/myProfilePage", (route) => false,
            arguments: {"route": route});
      },
      child: BlocBuilder<MyProfileAddJobBloc, MyProfileAddJobState>(
          builder: (context, state) {
        return Scaffold(
            appBar: buildAppBar(context, route),
            backgroundColor: AppColors.primaryBackground,
            body: myProfileAddJob(context));
      }),
    );
  }
}
