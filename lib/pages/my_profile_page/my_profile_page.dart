import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/values/colors.dart';
import 'bloc/my_profile_page_blocs.dart';
import 'bloc/my_profile_page_states.dart';
import 'widgets/my_profile_page_widget.dart';

class MyProfilePage extends StatefulWidget {
  const MyProfilePage({super.key});

  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
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
            "/applicationPage", (route) => false,
            arguments: {"route": route, "secondRoute": 0});
      },
      child: BlocBuilder<MyProfilePageBloc, MyProfilePageState>(
          builder: (context, state) {
            return Scaffold(
              appBar: buildAppBar(context, route),
              backgroundColor: AppColors.primaryBackground,
              body: myProfile(context, route),
            );
          }),
    );
  }
}
