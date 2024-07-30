import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:hcmus_alumni_mobile/pages/alumni_information/bloc/alumni_information_blocs.dart';
import 'package:hcmus_alumni_mobile/pages/alumni_information/bloc/alumni_information_events.dart';
import 'package:hcmus_alumni_mobile/pages/alumni_information/bloc/alumni_information_states.dart';
import 'package:hcmus_alumni_mobile/pages/alumni_information/widgets/alumni_information_widget.dart';

import '../../common/values/colors.dart';

class AlumniInformation extends StatefulWidget {
  const AlumniInformation({super.key});

  @override
  State<AlumniInformation> createState() => _AlumniInformationState();
}

class _AlumniInformationState extends State<AlumniInformation> {
  @override
  void initState() {
    super.initState();
    context.read<AlumniInformationBloc>().add(AlumniInformationResetEvent());
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false, // prevent back
      onPopInvoked: (_) async {
        final shouldExit = await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(translate('exit_application')),
            content: Text(translate('exit_application_question')),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: Text(translate('cancel')),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: Text(translate('exit')),
              ),
            ],
          ),
        );
        if (shouldExit) {
          SystemNavigator.pop();
        }
        return shouldExit ?? false;
      },
      child: BlocBuilder<AlumniInformationBloc, AlumniInformationState>(
          builder: (context, state) {
        return Container(
          color: AppColors.background,
          child: SafeArea(
              child: Scaffold(
            backgroundColor: AppColors.background,
            body: alumniInformation(context),
          )),
        );
      }),
    );
  }
}
