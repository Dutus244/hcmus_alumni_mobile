import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../common/values/colors.dart';
import 'widgets/other_profile_detail_widget.dart';

class OtherProfileDetail extends StatefulWidget {
  const OtherProfileDetail({super.key});

  @override
  State<OtherProfileDetail> createState() => _OtherProfileDetailState();
}

class _OtherProfileDetailState extends State<OtherProfileDetail> {
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
            "/otherProfilePage", (route) => false,
            arguments: {"route": route});
      },
      child: Scaffold(
        appBar: buildAppBar(context, route),
        backgroundColor: AppColors.primaryBackground,
        body:  otherProfileDetail(context),
      ),
    );
  }
}
