import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/widgets/flutter_toast.dart';
import 'bloc/sign_in_blocs.dart';

class SignInController {
  final BuildContext context;

  const SignInController({required this.context});

  Future<void> handleSignIn(String type) async {
    try {
      if (type == "email") {
        // BlocProvider.of<SignInBloc>(context).state
        final state = context.read<SignInBloc>().state;
        String emailAddress = state.email;
        String password = state.password;
        if (emailAddress.isEmpty) {
          toastInfo(msg: "Bạn phải điền email");
          return;
        }
        if (password.isEmpty) {
          toastInfo(msg: "Bạn phải điền password");
          return;
        }
        Navigator.of(context)
            .pushNamedAndRemoveUntil("landing", (route) => false);
      }
    } catch (e) {}
  }
}
