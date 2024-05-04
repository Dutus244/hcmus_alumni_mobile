import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hcmus_alumni_mobile/pages/alumni_verification/bloc/alumni_verification_blocs.dart';

class AlumniVerificationController {
  final BuildContext context;

  const AlumniVerificationController({required this.context});

  Future<void> hanldeAlumniVerification() async {
    try {
      final state = context.read<AlumniVerificationBloc>().state;
      String socialMediaLink = state.socialMediaLink;
      String studentId = state.studentId;
      int startYear = state.startYear;
      Navigator.of(context)
          .pushNamedAndRemoveUntil("/applicationPage", (route) => false);
    } catch (e) {}
  }
}
