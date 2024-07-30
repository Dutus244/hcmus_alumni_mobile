import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:hcmus_alumni_mobile/pages/sign_in/sign_in_controller.dart';
import 'package:hcmus_alumni_mobile/pages/sign_in/widgets/sign_in_widget.dart';

import '../../common/values/colors.dart';
import '../../global.dart';
import 'bloc/sign_in_blocs.dart';
import 'bloc/sign_in_events.dart';
import 'bloc/sign_in_states.dart';
import 'dart:io';
import 'dart:io' show Platform, exit;

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  void initState() {
    super.initState();
    context.read<SignInBloc>().add(SignInResetEvent());
    if (Global.storageService.getUserRememberLogin()) {
      SignInController(context: context).handleRememberSignIn(
          Global.storageService.getUserEmail(),
          Global.storageService.getUserPassword());
    }
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
          if (Platform.isAndroid) {
            SystemNavigator.pop();
          } else if (Platform.isIOS) {
            exit(0);
          }
        }
        return shouldExit ?? false;
      },
      child: BlocBuilder<SignInBloc, SignInState>(builder: (context, state) {
        return Container(
          color: AppColors.background,
          child: SafeArea(
              child: Scaffold(
            backgroundColor: AppColors.background,
            body: signIn(context),
          )),
        );
      }),
    );
  }
}
