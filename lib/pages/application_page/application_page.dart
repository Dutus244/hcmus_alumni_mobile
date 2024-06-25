import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hcmus_alumni_mobile/pages/application_page/widgets/application_page_widget.dart';
import 'package:hcmus_alumni_mobile/pages/application_page/bloc/application_page_blocs.dart';
import 'package:hcmus_alumni_mobile/pages/application_page/bloc/application_page_events.dart';
import 'package:hcmus_alumni_mobile/pages/application_page/bloc/application_page_states.dart';

import '../../common/values/colors.dart';

class ApplicationPage extends StatefulWidget {
  const ApplicationPage({super.key});

  @override
  State<ApplicationPage> createState() => _ApplicationPageState();
}

class _ApplicationPageState extends State<ApplicationPage> {
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic>? args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    var route = 0;
    var secondRoute = 0;
    if (args != null) {
      if (args["route"] != null) {
        route = args["route"];
      }
      if (args["secondRoute"] != null) {
        secondRoute = args["secondRoute"];
      }
      context
          .read<ApplicationPageBloc>()
          .add(TriggerApplicationPageEvent(route));
    }

    return BlocBuilder<ApplicationPageBloc, ApplicationPageState>(
        builder: (context, state) {
      return Container(
        color: AppColors.background,
        child: SafeArea(
          child: applicationPage(context, secondRoute),
        ),
      );
    });
  }
}
