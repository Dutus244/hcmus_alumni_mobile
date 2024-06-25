import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:hcmus_alumni_mobile/pages/alumni_information/bloc/alumni_information_blocs.dart';

import '../../common/widgets/flutter_toast.dart';
import 'dart:io';

class AlumniInformationController {
  final BuildContext context;

  const AlumniInformationController({required this.context});

  Future<void> handleAlumniInformation() async {
    try {
      final state = context.read<AlumniInformationBloc>().state;
      String fullName = state.fullName;
      File? avatar = state.avatar;
      if (fullName.isEmpty) {
        toastInfo(msg: translate('must_fill_full_name'));
        return;
      }
      Navigator.of(context).pushNamedAndRemoveUntil(
        "/alumniVerification",
        (route) => false,
        arguments: {
          "fullName": fullName,
          "avatar": avatar,
        },
      );
    } catch (e) {}
  }
}
