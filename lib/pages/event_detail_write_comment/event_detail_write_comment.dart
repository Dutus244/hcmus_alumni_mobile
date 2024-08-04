import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hcmus_alumni_mobile/pages/event_detail_write_comment/bloc/event_detail_write_comment_events.dart';
import 'package:hcmus_alumni_mobile/pages/event_detail_write_comment/widgets/event_detail_write_comment_widget.dart';

import '../../common/values/colors.dart';
import '../../model/event.dart';
import 'bloc/event_detail_write_comment_blocs.dart';
import 'bloc/event_detail_write_comment_states.dart';

class EventDetailWriteComment extends StatefulWidget {
  const EventDetailWriteComment({super.key});

  @override
  State<EventDetailWriteComment> createState() =>
      _EventDetailWriteCommentState();
}

class _EventDetailWriteCommentState extends State<EventDetailWriteComment> {
  @override
  void initState() {
    super.initState();
    context
        .read<EventDetailWriteCommentBloc>()
        .add(EventDetailWriteCommentResetEvent());
    context.read<EventDetailWriteCommentBloc>().add(IsLoadingEvent(false));
  }

  late Event event;

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic>? args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    if (args != null) {
      event = args["event"];
    }

    return BlocBuilder<EventDetailWriteCommentBloc,
        EventDetailWriteCommentState>(builder: (context, state) {
      return Scaffold(
        appBar: buildAppBar(context),
        backgroundColor: AppColors.background,
        body: eventDetailWriteComment(context, event),
      );
    });
  }
}
