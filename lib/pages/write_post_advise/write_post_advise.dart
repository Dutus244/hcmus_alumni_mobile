import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hcmus_alumni_mobile/pages/write_post_advise/write_post_advise_controller.dart';
import 'bloc/write_post_advise_events.dart';
import 'widgets/write_post_advise_widget.dart';

import '../../common/values/colors.dart';
import '../../common/widgets/app_bar.dart';
import 'bloc/write_post_advise_blocs.dart';
import 'bloc/write_post_advise_states.dart';

class WritePostAdvise extends StatefulWidget {
  const WritePostAdvise({super.key});

  @override
  State<WritePostAdvise> createState() => _WritePostAdviseState();
}

class _WritePostAdviseState extends State<WritePostAdvise> {
  @override
  Widget build(BuildContext context) {
    var route;
    Map<String, dynamic>? args =
    ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    if (args != null) {
      route = args["route"];
      // Now you can use the passedValue in your widget
    }

    return PopScope(
        canPop: false, // prevent back
        onPopInvoked: (_) async {
          Navigator.of(context).pushNamedAndRemoveUntil(
            "/applicationPage",
            (route) => false,
            arguments: {
              "route": route,
              "secondRoute": 0,
            },
          );
        },
        child: BlocBuilder<WritePostAdviseBloc, WritePostAdviseState>(
            builder: (context, state) {
          return Scaffold(
            appBar: buildAppBar(context, 'Tạo bài viết'),
            backgroundColor: AppColors.primaryBackground,
            body: BlocProvider.of<WritePostAdviseBloc>(context)
                .state.page == 0 ? writePost(context, route) : editPicture(context, route)
          );
        }));
  }
}
