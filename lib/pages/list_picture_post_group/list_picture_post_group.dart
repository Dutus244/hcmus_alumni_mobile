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

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic>? args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    if (args != null) {
      post = args["post"];
      groupId = args["groupId"];
    }

    return Scaffold(
      appBar: buildAppBar(context),
      backgroundColor: AppColors.primaryText,
      body: listPicture(post.pictures),
    );
  }
}
