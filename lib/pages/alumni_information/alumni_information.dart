import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
            title: Text('Thoát ứng dụng'),
            content: Text('Bạn có muốn thoát ứng dụng?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: Text('Huỷ'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: Text('Thoát'),
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
          color: AppColors.primaryBackground,
          child: SafeArea(
              child: Scaffold(
            backgroundColor: AppColors.primaryBackground,
            body: alumniInformation(context),
          )),
        );
      }),
    );
  }
}
