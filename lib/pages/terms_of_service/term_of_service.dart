import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../common/values/colors.dart';
import 'widgets/term_of_service_widget.dart';

class TermOfService extends StatefulWidget {
  const TermOfService({super.key});

  @override
  State<TermOfService> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<TermOfService> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(context),
        backgroundColor: AppColors.background,
        body: Container());
  }
}