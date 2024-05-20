import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hcmus_alumni_mobile/pages/register/register_controller.dart';

import '../../common/values/colors.dart';
import '../../common/values/fonts.dart';
import 'bloc/register_blocs.dart';
import 'bloc/register_events.dart';
import 'bloc/register_states.dart';
import 'widgets/register_widget.dart';
import 'dart:io';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  void initState() {
    super.initState();
    context.read<RegisterBloc>().add(RegisterResetEvent());
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (_) async {
        Navigator.of(context).pushNamed("/signIn");
      },
      child:
          BlocBuilder<RegisterBloc, RegisterState>(builder: (context, state) {
        return Container(
          color: AppColors.primaryBackground,
          child: SafeArea(
              child: Scaffold(
            backgroundColor: AppColors.primaryBackground,
            body: register(context),
          )),
        );
      }),
    );
  }
}
