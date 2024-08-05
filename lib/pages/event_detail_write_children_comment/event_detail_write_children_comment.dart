import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hcmus_alumni_mobile/pages/event_detail_write_children_comment/widgets/event_detail_write_children_comment_widget.dart';

import '../../common/values/colors.dart';
import '../../model/comment.dart';
import '../../model/event.dart';
import 'bloc/event_detail_write_children_comment_blocs.dart';
import 'bloc/event_detail_write_children_comment_events.dart';
import 'bloc/event_detail_write_children_comment_states.dart';

class EventDetailWriteChildrenComment extends StatefulWidget {
  const EventDetailWriteChildrenComment({super.key});

  @override
  State<EventDetailWriteChildrenComment> createState() =>
      _EventDetailWriteChildrenCommentState();
}

class _EventDetailWriteChildrenCommentState
    extends State<EventDetailWriteChildrenComment> {
  late Event event;
  late Comment comment;

  @override
  void initState() {
    super.initState();
    context
        .read<EventDetailWriteChildrenCommentBloc>()
        .add(EventDetailWriteChildrenCommentResetEvent());
    context.read<EventDetailWriteChildrenCommentBloc>().add(IsLoadingEvent(false));
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic>? args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    if (args != null) {
      event = args["event"];
      comment = args["comment"];
    }

    return BlocBuilder<EventDetailWriteChildrenCommentBloc,
        EventDetailWriteChildrenCommentState>(builder: (context, state) {
      return Scaffold(
        appBar: buildAppBar(context),
        backgroundColor: AppColors.background,
        body:
        eventDetailWriteChildrenComment(context, event, comment),
      );
    });
  }
}
