import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/widgets/flutter_toast.dart';
import 'bloc/sign_in_blocs.dart';
import 'package:http/http.dart' as http;

class SignInController {
  final BuildContext context;

  const SignInController({required this.context});

  Future<void> handleSignIn() async {
    final state = context.read<SignInBloc>().state;
    String email = state.email;
    String password = state.password;
    if (email.isEmpty) {
      toastInfo(msg: "Bạn phải điền email");
      return;
    }
    if (!isValidEmail(email)) {
      toastInfo(msg: "Email không hợp lệ");
      return;
    }
    if (password.isEmpty) {
      toastInfo(msg: "Bạn phải điền mật khẩu");
      return;
    }

    // Test api
    // var url = Uri.parse(
    //     'http://localhost:4000/auth/signin'); // Sử dụng http, không phải https
    // var params = {"username": "student15", "password": "1"};
    //
    // try {
    //   var response = await http.post(url, body: params);
    //
    //   if (response.statusCode == 200) {
    //     print('Response body: ${response.body}');
    //   } else {
    //     print('Request failed with status: ${response.statusCode}');
    //   }
    // } catch (error, stacktrace) {
    //   print("Exception occurred: $error\nStackTrace: $stacktrace");
    // }
    Navigator.of(context)
        .pushNamedAndRemoveUntil("/applicationPage", (route) => false);
  }

  bool isValidEmail(String email) {
    final RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }
}
