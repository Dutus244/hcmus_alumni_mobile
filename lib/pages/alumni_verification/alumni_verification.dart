import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hcmus_alumni_mobile/pages/alumni_verification/widgets/alumni_verification_widget.dart';

import '../../common/values/colors.dart';
import 'bloc/alumni_verification_blocs.dart';
import 'bloc/alumni_verification_events.dart';
import 'bloc/alumni_verification_states.dart';

class AlumniVerification extends StatefulWidget {
  const AlumniVerification({super.key});

  @override
  State<AlumniVerification> createState() => _AlumniVerificationState();
}

class _AlumniVerificationState extends State<AlumniVerification> {
  late String fullName;
  File? avatar;
  @override
  void initState() {
    super.initState();
    context.read<AlumniVerificationBloc>().add(AlumniVerificationResetEvent());
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic>? args =
    ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    if (args != null) {
      fullName = args["fullName"];
      avatar = args["avatar"];
    }

    return PopScope(
      canPop: false, // prevent back
      onPopInvoked: (_) async {
        Navigator.of(context).pushNamed("/alumniInformation");
      },
      child: BlocBuilder<AlumniVerificationBloc, AlumniVerificationState>(
          builder: (context, state) {
        return Container(
          color: AppColors.background,
          child: SafeArea(
              child: Scaffold(
            backgroundColor: AppColors.background,
            body: alumniVerification(context, fullName, avatar),
          )),
        );
      }),
    );
  }
}
