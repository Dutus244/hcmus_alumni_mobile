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
    Map<String, dynamic>? args =
    ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    var route = 0;
    if (args != null) {
      route = args["route"];
    }

    return PopScope(
      canPop: false, // prevent back
      onPopInvoked: (_) async {
        Navigator.of(context).pushNamedAndRemoveUntil(
            "/myProfilePage", (route) => false,
            arguments: {"route": route});
      },
      child: Scaffold(
          appBar: buildAppBar(context, route),
          backgroundColor: AppColors.primaryBackground,
          body: optionPage(context, route),
      )
    );
  }
}
