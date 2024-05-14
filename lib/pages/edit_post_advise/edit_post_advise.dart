import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hcmus_alumni_mobile/pages/edit_post_advise/bloc/edit_post_advise_events.dart';
import 'package:hcmus_alumni_mobile/pages/edit_post_advise/edit_post_advise_controller.dart';
import '../../model/post.dart';
import 'bloc/edit_post_advise_blocs.dart';
import 'bloc/edit_post_advise_states.dart';
import 'widgets/edit_post_advise_widget.dart';

import '../../common/values/colors.dart';
import '../../common/widgets/app_bar.dart';

class EditPostAdvise extends StatefulWidget {
  const EditPostAdvise({super.key});

  @override
  State<EditPostAdvise> createState() => _EditPostAdviseState();
}

class _EditPostAdviseState extends State<EditPostAdvise> {
  late Post post;

  @override
  Widget build(BuildContext context) {
    var route;
    Map<String, dynamic>? args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    if (args != null) {
      route = args["route"];
      post = args["post"];
      // Now you can use the passedValue in your widget
      EditPostAdviseController(context: context).handleLoad(post);
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
        child: BlocBuilder<EditPostAdviseBloc, EditPostAdviseState>(
            builder: (context, state) {
          return Scaffold(
              appBar: buildAppBar(context, 'Chỉnh sửa bài viết'),
              backgroundColor: AppColors.primaryBackground,
              body: BlocProvider.of<EditPostAdviseBloc>(context).state.page == 0
                  ? writePost(context, route, post.id)
                  : editPicture(context, route));
        }));
  }
}
