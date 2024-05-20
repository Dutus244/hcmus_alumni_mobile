import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../common/values/colors.dart';
import '../../common/widgets/app_bar.dart';
import '../../model/group.dart';
import 'widget/group_info_widget.dart';

class GroupInfo extends StatefulWidget {
  const GroupInfo({super.key});

  @override
  State<GroupInfo> createState() => _GroupInfoState();
}

class _GroupInfoState extends State<GroupInfo> {
  late int secondRoute;
  late Group group;

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic>? args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    if (args != null) {
      group = args["group"];
      secondRoute = args["secondRoute"];
    }

    return PopScope(
        canPop: false, // prevent back
        onPopInvoked: (_) async {
          Navigator.of(context).pushNamedAndRemoveUntil(
            "/groupDetail",
                (route) => false,
            arguments: {
              "id": group.id,
              "secondRoute": secondRoute,
            },
          );
        },
        child: Container(
          child: Scaffold(
            appBar: buildAppBar(context, group.name),
            backgroundColor: AppColors.primaryBackground,
            body: infoGroup(context, group, secondRoute),
          ),
        ));
  }
}
