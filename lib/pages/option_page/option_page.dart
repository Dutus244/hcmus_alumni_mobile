import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../common/values/colors.dart';
import 'widgets/option_page_widget.dart';

class OptionPage extends StatefulWidget {
  const OptionPage({super.key});

  @override
  State<OptionPage> createState() => _OptionPageState();
}

class _OptionPageState extends State<OptionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      backgroundColor: AppColors.primaryBackground,
      body: optionPage(context),
    );
  }
}
