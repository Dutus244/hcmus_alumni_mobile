import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/write_post_group_events.dart';
import 'widgets/write_post_group_widget.dart';

import '../../common/values/colors.dart';
import 'bloc/write_post_group_blocs.dart';
import 'bloc/write_post_group_states.dart';

class WritePostGroup extends StatefulWidget {
  const WritePostGroup({super.key});

  @override
  State<WritePostGroup> createState() => _WritePostGroupState();
}

class _WritePostGroupState extends State<WritePostGroup> {
  late String id;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic>? args =
    ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    if (args != null) {
      id = args["id"];
    }

    return BlocBuilder<WritePostGroupBloc, WritePostGroupState>(
      builder: (context, state) {
        return WillPopScope(
            onWillPop: () async {
              return !state.isLoading;
            },
            child: Scaffold(
                appBar: buildAppBar(context),
                backgroundColor: AppColors.background,
                body: BlocProvider.of<WritePostGroupBloc>(context)
                    .state.page == 0 ? writePost(context, id) : editPicture(context)
            ));
      },
    );
  }
}
