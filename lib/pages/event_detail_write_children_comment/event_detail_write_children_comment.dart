import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hcmus_alumni_mobile/pages/event_detail_write_children_comment/widgets/event_detail_write_children_comment_widget.dart';

import '../../common/values/colors.dart';
import '../../common/widgets/app_bar.dart';
import '../../model/comment.dart';
import '../../model/event.dart';
import 'bloc/event_detail_write_children_comment_blocs.dart';
import 'bloc/event_detail_write_children_comment_events.dart';
import 'bloc/event_detail_write_children_comment_states.dart';
import 'event_detail_write_children_comment_controller.dart';

class EventDetailWriteChildrenComment extends StatefulWidget {
  const EventDetailWriteChildrenComment({super.key});

  @override
  State<EventDetailWriteChildrenComment> createState() =>
      _EventDetailWriteChildrenCommentState();
}

class _EventDetailWriteChildrenCommentState
    extends State<EventDetailWriteChildrenComment> {
  @override
  void initState() {
    super.initState();
    context
        .read<EventDetailWriteChildrenCommentBloc>()
        .add(EventDetailWriteChildrenCommentResetEvent());
  }

  late Event event;
  late Comment comment;

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic>? args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    if (args != null) {
      event = args["event"];
      comment = args["comment"];
    }

    return PopScope(
        canPop: false, // prevent back
        onPopInvoked: (_) async {
          Navigator.of(context).pushNamedAndRemoveUntil(
            "/eventDetail",
            (route) => false,
            arguments: {
              "route": 1,
              "id": event.id,
            },
          );
        },
        child: BlocBuilder<EventDetailWriteChildrenCommentBloc,
            EventDetailWriteChildrenCommentState>(builder: (context, state) {
          return Scaffold(
            appBar: buildAppBar(context, 'Sự kiện'),
            backgroundColor: AppColors.primaryBackground,
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    children: [
                      header(event, comment),
                      buildTextField('Bình luận của bạn', 'comment', '',
                          (value) {
                        context
                            .read<EventDetailWriteChildrenCommentBloc>()
                            .add(CommentEvent(value));
                      }),
                    ],
                  ),
                ),
                navigation(
                    () {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        "/eventDetail",
                        (route) => false,
                        arguments: {
                          "route": 1,
                          "id": event.id,
                        },
                      );
                    },
                    BlocProvider.of<EventDetailWriteChildrenCommentBloc>(
                            context)
                        .state
                        .comment,
                    () {
                      EventDetailWriteChildrenCommentController(
                              context: context)
                          .handleLoadWriteComment(event.id, comment.id);
                    }),
              ],
            ),
          );
        }));
  }
}
