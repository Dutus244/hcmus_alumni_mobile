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

class EditPostAdvise extends StatefulWidget {
  const EditPostAdvise({super.key});

  @override
  State<EditPostAdvise> createState() => _EditPostAdviseState();
}

class _EditPostAdviseState extends State<EditPostAdvise> {
  late Post post;
  int route = 0;
  int profile = 0;
  String page = "";

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic>? args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    if (args != null) {
      post = args["post"];
      if (args["route"] != null) {
        route = args["route"];
      }
      if (args["profile"] != null) {
        profile = args["profile"];
      }
      if (args["page"] != null) {
        page = args["page"];
      }
      // Now you can use the passedValue in your widget
      context
          .read<EditPostAdviseBloc>()
          .add(EditPostAdviseResetEvent());
      EditPostAdviseController(context: context).handleLoad(post);
    }

    return PopScope(
        canPop: false, // prevent back
        onPopInvoked: (_) async {
          if (BlocProvider
              .of<EditPostAdviseBloc>(context)
              .state
              .page ==
              0) {
            if (profile == 0) {
              Navigator.of(context).pushNamedAndRemoveUntil(
                "/applicationPage",
                    (route) => false,
                arguments: {
                  "route": route,
                  "secondRoute": 0,
                },
              );
            }
            else {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  "/myProfilePage", (route) => false,
                  arguments: {"page": page, "route": route});
            }
          } else {
            context.read<EditPostAdviseBloc>().add(PageEvent(0));
          }
        },
        child: BlocBuilder<EditPostAdviseBloc, EditPostAdviseState>(
            builder: (context, state) {
          return Scaffold(
              appBar: buildAppBar(context, route, post.id, profile, page),
              backgroundColor: AppColors.primaryBackground,
              body: BlocProvider.of<EditPostAdviseBloc>(context).state.page == 0
                  ? writePost(context, route, post.id, profile, page)
                  : editPicture(context, route));
        }));
  }
}
