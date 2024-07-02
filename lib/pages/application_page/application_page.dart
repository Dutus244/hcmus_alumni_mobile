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
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final args =
      ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
      if (args != null) {
        final route = args["route"] ?? 0;
        context.read<ApplicationPageBloc>().add(TriggerApplicationPageEvent(route));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final args =
    ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    final secondRoute = args?["secondRoute"] ?? 0;

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
