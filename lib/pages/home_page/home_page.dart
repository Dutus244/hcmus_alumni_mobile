import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:hcmus_alumni_mobile/common/services/socket_service.dart';
import 'package:hcmus_alumni_mobile/common/values/colors.dart';
import 'package:hcmus_alumni_mobile/pages/home_page/bloc/home_page_blocs.dart';
import 'package:hcmus_alumni_mobile/pages/home_page/bloc/home_page_states.dart';
import 'package:hcmus_alumni_mobile/pages/home_page/home_page_controller.dart';
import 'package:hcmus_alumni_mobile/pages/home_page/widgets/home_page_widget.dart';
import 'dart:io' show Platform, exit;

import '../../common/widgets/app_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    HomePageController(context: context).handleLoadEventData();
    HomePageController(context: context).handleLoadNewsData();
    HomePageController(context: context).handleLoadHallOfFameData();
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
            socketService.disconnect();
            if (Platform.isAndroid) {
              SystemNavigator.pop();
            } else if (Platform.isIOS) {
              exit(0);
            }
          }
          return shouldExit ?? false;
        },
        child:
            BlocBuilder<HomePageBloc, HomePageState>(builder: (context, state) {
          return Scaffold(
            appBar: buildAppBar(context, translate('home')),
            backgroundColor: AppColors.background,
            body: homePage(context),
          );
        }));
  }
}
