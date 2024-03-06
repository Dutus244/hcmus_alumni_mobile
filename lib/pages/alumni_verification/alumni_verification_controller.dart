import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hcmus_alumni_mobile/pages/alumni_verification/bloc/alumni_verification_blocs.dart';

import '../../common/widgets/flutter_toast.dart';
import 'bloc/alumni_verification_events.dart';

class AlumniVerificationController {
  final BuildContext context;

  const AlumniVerificationController({required this.context});

  Future<void> hanldeAlumniVerification() async {
    try {
      final state = context.read<AlumniVerificationBloc>().state;
      String fullName = state.fullName;
      String studentId = state.studentId;
      int startYear = state.startYear;
      if (fullName.isEmpty) {
        toastInfo(msg: "Bạn phải điền họ và tên");
        return;
      }
      if (studentId.isEmpty) {
        toastInfo(msg: "Bạn phải điền MSSV");
        return;
      }
      if (startYear == 0) {
        toastInfo(msg: "Bạn phải điền năm nhập học");
        return;
      }
      context.read<AlumniVerificationBloc>().add(AlumniVerificationResetEvent());
    } catch (e) {}
  }
}