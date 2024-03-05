import 'package:flutter/cupertino.dart';

class EmailVerificationController {
  final BuildContext context;

  const EmailVerificationController({required this.context});

  Future<void> hanldeResendCode(String email) async {

  }

  Future<void> hanldeEmailVerification() async {
    Navigator.of(context).pushNamed("alumniVerification");
  }
}