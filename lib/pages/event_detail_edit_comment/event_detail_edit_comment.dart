import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/values/colors.dart';
import '../../model/comment.dart';
import '../../model/event.dart';
import 'bloc/event_detail_edit_comment_blocs.dart';
import 'bloc/event_detail_edit_comment_events.dart';
import 'bloc/event_detail_edit_comment_states.dart';
import 'widgets/event_detail_edit_comment_widget.dart';

class EventDetailEditComment extends StatefulWidget {
  const EventDetailEditComment({super.key});

  @override
  State<EventDetailEditComment> createState() => _EventDetailEditCommentState();
}

class _EventDetailEditCommentState extends State<EventDetailEditComment> {
  late Event event;
  late Comment comment;

  @override
  void initState() {
    super.initState();
    context
        .read<EventDetailEditCommentBloc>()
        .add(EventDetailEditCommentResetEvent());
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic>? args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    if (args != null) {
      event = args["event"];
      comment = args["comment"];
      context
          .read<EventDetailEditCommentBloc>()
          .add(CommentEvent(comment.content));
    }

    return BlocBuilder<EventDetailEditCommentBloc,
        EventDetailEditCommentState>(builder: (context, state) {
      return Scaffold(
        appBar: buildAppBar(context),
        backgroundColor: AppColors.background,
        body:
        eventDetailEditComment(context, event, comment),
      );
    });
  }
}
