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

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic>? args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    if (args != null) {
      post = args["post"];
      // Now you can use the passedValue in your widget
      context
          .read<EditPostAdviseBloc>()
          .add(EditPostAdviseResetEvent());
      EditPostAdviseController(context: context).handleLoad(post);
    }

    return BlocBuilder<EditPostAdviseBloc, EditPostAdviseState>(
        builder: (context, state) {
          return Scaffold(
              appBar: buildAppBar(context),
              backgroundColor: AppColors.primaryBackground,
              body: BlocProvider.of<EditPostAdviseBloc>(context).state.page == 0
                  ? writePost(context, post.id)
                  : editPicture(context));
        });
  }
}
