import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../model/post.dart';
import 'bloc/edit_post_group_blocs.dart';
import 'bloc/edit_post_group_states.dart';
import 'bloc/edit_post_group_events.dart';
import 'edit_post_group_controller.dart';
import 'widgets/edit_post_group_widget.dart';

import '../../common/values/colors.dart';

class EditPostGroup extends StatefulWidget {
  const EditPostGroup({super.key});

  @override
  State<EditPostGroup> createState() => _EditPostGroupState();
}

class _EditPostGroupState extends State<EditPostGroup> {
  late Post post;
  late String id;
  int secondRoute = 0;

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic>? args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    if (args != null) {
      id = args["id"];
      post = args["post"];
      if (args["secondRoute"] != null) {
        secondRoute = args["secondRoute"];
      }
      // Now you can use the passedValue in your widget
      context
          .read<EditPostGroupBloc>()
          .add(EditPostGroupResetEvent());
      EditPostGroupController(context: context).handleLoad(post);
    }

    return PopScope(
        canPop: false, // prevent back
        onPopInvoked: (_) async {
          if (BlocProvider
              .of<EditPostGroupBloc>(context)
              .state
              .page ==
              0) {
            Navigator.of(context).pushNamedAndRemoveUntil(
              "/groupDetail",
                  (route) => false,
              arguments: {
                "id": id,
                "secondRoute": secondRoute,
              },
            );
          } else {
            context.read<EditPostGroupBloc>().add(PageEvent(0));
          }
        },
        child: BlocBuilder<EditPostGroupBloc, EditPostGroupState>(
            builder: (context, state) {
          return Scaffold(
              appBar: buildAppBar(context, secondRoute, post.id, id),
              backgroundColor: AppColors.primaryBackground,
              body: BlocProvider.of<EditPostGroupBloc>(context).state.page == 0
                  ? writePost(context, secondRoute, post.id, id)
                  : editPicture(context, secondRoute));
        }));
  }
}
