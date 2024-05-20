import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hcmus_alumni_mobile/model/post.dart';
import '../../common/values/colors.dart';
import 'widgets/list_picture_post_group_widget.dart';

class ListPicturePostGroup extends StatefulWidget {
  const ListPicturePostGroup({super.key});

  @override
  State<ListPicturePostGroup> createState() => _ListPicturePostGroupState();
}

class _ListPicturePostGroupState extends State<ListPicturePostGroup> {
  late Post post;
  late String groupId;
  late int secondRoute;

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic>? args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    if (args != null) {
      post = args["post"];
      groupId = args["groupId"];
      secondRoute = args["secondRoute"];
    }

    return PopScope(
      canPop: false, // prevent back
      onPopInvoked: (_) async {
        Navigator.of(context).pushNamedAndRemoveUntil(
          "/groupDetail",
              (route) => false,
          arguments: {
            "id": groupId,
            "secondRoute": secondRoute,
          },
        );
      },
      child: Scaffold(
        appBar: buildAppBar(context, groupId, secondRoute),
        backgroundColor: AppColors.primaryText,
        body: listPicture(post.picture),
      ),
    );
  }
}
