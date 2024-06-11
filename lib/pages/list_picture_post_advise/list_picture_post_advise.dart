import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hcmus_alumni_mobile/model/post.dart';
import '../../common/values/colors.dart';
import 'widgets/list_picture_post_advise_widget.dart';

class ListPicturePostAdvise extends StatefulWidget {
  const ListPicturePostAdvise({super.key});

  @override
  State<ListPicturePostAdvise> createState() => _ListPicturePostAdviseState();
}

class _ListPicturePostAdviseState extends State<ListPicturePostAdvise> {
  late Post post;

  @override
  Widget build(BuildContext context) {
    var profile = 0;
    var route = 0;

    Map<String, dynamic>? args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    if (args != null) {
      post = args["post"];
      if (args["profile"] != null) {
        profile = args["profile"];
      }
      if (profile == 1) {
        route = args["route"];
      }
    }

    return PopScope(
      canPop: false, // prevent back
      onPopInvoked: (_) async {
        if (profile == 0) {
          Navigator.of(context).pushNamedAndRemoveUntil(
            "/applicationPage",
                (route) => false,
            arguments: {
              "route": 2,
              "secondRoute": 0,
            },
          );
        }
        else {
          Navigator.of(context).pushNamedAndRemoveUntil(
              "/myProfilePage", (route) => false,
              arguments: {"route": route});
        }
      },
      child: Scaffold(
        appBar: buildAppBar(context, profile, route),
        backgroundColor: AppColors.primaryText,
        body: listPicture(post.pictures),
      ),
    );
  }
}
