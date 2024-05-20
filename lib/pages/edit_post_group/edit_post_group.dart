import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../model/post.dart';
import 'bloc/edit_post_group_blocs.dart';
import 'bloc/edit_post_group_states.dart';
import 'edit_post_group_controller.dart';
import 'widgets/edit_post_group_widget.dart';

import '../../common/values/colors.dart';
import '../../common/widgets/app_bar.dart';

class EditPostGroup extends StatefulWidget {
  const EditPostGroup({super.key});

  @override
  State<EditPostGroup> createState() => _EditPostGroupState();
}

class _EditPostGroupState extends State<EditPostGroup> {
  late Post post;
  late String id;
  late int secondRoute;

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic>? args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    if (args != null) {
      id = args["id"];
      secondRoute = args["secondRoute"];
      post = args["post"];
      // Now you can use the passedValue in your widget
      EditPostGroupController(context: context).handleLoad(post);
    }

    return PopScope(
        canPop: false, // prevent back
        onPopInvoked: (_) async {
          Navigator.of(context).pushNamedAndRemoveUntil(
            "/applicationPage",
            (route) => false,
            arguments: {
              "route": 2,
              "secondRoute": 0,
            },
          );
        },
        child: BlocBuilder<EditPostGroupBloc, EditPostGroupState>(
            builder: (context, state) {
          return Scaffold(
              appBar: buildAppBar(context, 'Chỉnh sửa bài viết'),
              backgroundColor: AppColors.primaryBackground,
              body: BlocProvider.of<EditPostGroupBloc>(context).state.page == 0
                  ? writePost(context, secondRoute, post.id, id)
                  : editPicture(context, secondRoute));
        }));
  }
}
