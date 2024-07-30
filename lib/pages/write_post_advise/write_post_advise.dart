import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hcmus_alumni_mobile/pages/write_post_advise/write_post_advise_controller.dart';
import 'bloc/write_post_advise_events.dart';
import 'widgets/write_post_advise_widget.dart';

import '../../common/values/colors.dart';
import 'bloc/write_post_advise_blocs.dart';
import 'bloc/write_post_advise_states.dart';

class WritePostAdvise extends StatefulWidget {
  const WritePostAdvise({super.key});

  @override
  State<WritePostAdvise> createState() => _WritePostAdviseState();
}

class _WritePostAdviseState extends State<WritePostAdvise> {
  @override
  void initState() {
    super.initState();
    context
        .read<WritePostAdviseBloc>()
        .add(WritePostAdviseResetEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WritePostAdviseBloc, WritePostAdviseState>(
        builder: (context, state) {
          return Scaffold(
              appBar: buildAppBar(context),
              backgroundColor: AppColors.background,
              body: BlocProvider.of<WritePostAdviseBloc>(context)
                  .state.page == 0 ? writePost(context) : editPicture(context)
          );
        });
  }
}
