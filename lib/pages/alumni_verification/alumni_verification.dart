import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hcmus_alumni_mobile/pages/alumni_verification/widgets/alumni_verification_widget.dart';

import '../../common/values/colors.dart';
import '../../common/values/fonts.dart';
import 'alumni_verification_controller.dart';
import 'bloc/alumni_verification_blocs.dart';
import 'bloc/alumni_verification_events.dart';
import 'bloc/alumni_verification_states.dart';

class AlumniVerification extends StatefulWidget {
  const AlumniVerification({super.key});

  @override
  State<AlumniVerification> createState() => _AlumniVerificationState();
}

class _AlumniVerificationState extends State<AlumniVerification> {
  @override
  void initState() {
    super.initState();
    context.read<AlumniVerificationBloc>().add(AlumniVerificationResetEvent());
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false, // prevent back
      onPopInvoked: (_) async {
        Navigator.of(context).pushNamed("/alumniInformation");
      },
      child: BlocBuilder<AlumniVerificationBloc, AlumniVerificationState>(
          builder: (context, state) {
        return Container(
          color: AppColors.primaryBackground,
          child: SafeArea(
              child: Scaffold(
            backgroundColor: AppColors.primaryBackground,
            body: alumniVerification(context),
          )),
        );
      }),
    );
  }
}
