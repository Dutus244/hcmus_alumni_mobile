import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hcmus_alumni_mobile/pages/alumni_information/bloc/alumni_information_blocs.dart';

import '../../common/widgets/flutter_toast.dart';
import 'dart:io';

class AlumniInformationController {
  final BuildContext context;

  const AlumniInformationController({required this.context});

  Future<void> hanldeAlumniInformation() async {
    try {
      final state = context.read<AlumniInformationBloc>().state;
      String fullName = state.fullName;
      File? avatar = state.avatar;
      if (fullName.isEmpty) {
        toastInfo(msg: "Bạn phải điền họ và tên");
        return;
      }
      Navigator.of(context).pushNamed("/alumniVerification");
    } catch (e) {}
  }
}
