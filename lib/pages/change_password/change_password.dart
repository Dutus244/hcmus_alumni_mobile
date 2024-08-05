import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../common/values/colors.dart';
import 'bloc/change_password_blocs.dart';
import 'bloc/change_password_events.dart';
import 'bloc/change_password_states.dart';
import 'widgets/change_password_widget.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  @override
  void initState() {
    super.initState();
    context.read<ChangePasswordBloc>().add(ChangePasswordResetEvent());
    context.read<ChangePasswordBloc>().add(IsLoadingEvent(false));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChangePasswordBloc, ChangePasswordState>(
        builder: (context, state) {
      return Scaffold(
          appBar: buildAppBar(context),
          backgroundColor: AppColors.background,
          body: changePassword(context));
    });
  }
}
