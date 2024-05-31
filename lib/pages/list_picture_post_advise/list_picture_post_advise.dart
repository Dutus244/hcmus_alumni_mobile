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
    Map<String, dynamic>? args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    if (args != null) {
      post = args["post"];
    }

    return PopScope(
      canPop: false, // prevent back
      onPopInvoked: (_) async {
        Navigator.of(context).pushNamedAndRemoveUntil(
            "/applicationPage", (route) => false,
            arguments: {"route": 2, "secondRoute": 0});
      },
      child: Scaffold(
        appBar: buildAppBar(context),
        backgroundColor: AppColors.primaryText,
        body: listPicture(post.pictures),
      ),
    );
  }
}
