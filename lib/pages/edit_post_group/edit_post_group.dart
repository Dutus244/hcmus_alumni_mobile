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
  Post? post;
  String id = "";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      handleNavigation();
    });
  }

  void handleNavigation() {
    Map<String, dynamic>? args =
    ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    if (args != null) {
      id = args["id"];
      post = args["post"];
      EditPostGroupController(context: context).handleLoad(post!.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditPostGroupBloc, EditPostGroupState>(
      builder: (context, state) {
        return WillPopScope(
          onWillPop: () async {
            return !state.isLoading;
          },
          child: Scaffold(
          appBar: buildAppBar(context),
        backgroundColor: AppColors.background,
        body: BlocProvider.of<EditPostGroupBloc>(context).state.page == 0
        ? writePost(context, post, id)
            : editPicture(context),
        ));
      },
    );
  }
}
