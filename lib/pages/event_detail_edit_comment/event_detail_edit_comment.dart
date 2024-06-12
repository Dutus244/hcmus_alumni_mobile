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
  int route = 0;
  int profile = 0;

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
      if (args["route"] != null) {
        route = args["route"];
      }
      if (args["profile"] != null) {
        profile = args["profile"];
      }
      context
          .read<EventDetailEditCommentBloc>()
          .add(CommentEvent(comment.content));
    }

    return PopScope(
        canPop: false, // prevent back
        onPopInvoked: (_) async {
          Navigator.of(context).pushNamedAndRemoveUntil(
            "/eventDetail",
            (route) => false,
            arguments: {
              "route": route,
              "id": event.id,
              "profile": profile,
            },
          );
        },
        child: BlocBuilder<EventDetailEditCommentBloc,
            EventDetailEditCommentState>(builder: (context, state) {
          return Scaffold(
            appBar: buildAppBar(context, route, event, profile),
            backgroundColor: AppColors.primaryBackground,
            body:
                eventDetailEditComment(context, event, route, comment, profile),
          );
        }));
  }
}
