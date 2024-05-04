import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hcmus_alumni_mobile/pages/event_detail_write_comment/bloc/event_detail_write_comment_events.dart';
import 'package:hcmus_alumni_mobile/pages/event_detail_write_comment/widgets/event_detail_write_comment_widget.dart';

import '../../common/values/colors.dart';
import '../../common/widgets/app_bar.dart';
import '../../model/event.dart';
import 'bloc/event_detail_write_comment_blocs.dart';
import 'bloc/event_detail_write_comment_states.dart';
import 'event_detail_write_comment_controller.dart';

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
  }

  late Event event;

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic>? args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    if (args != null) {
      event = args["event"];
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
        child: BlocBuilder<EventDetailWriteCommentBloc,
            EventDetailWriteCommentState>(builder: (context, state) {
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
                      header(event),
                      buildTextField('Bình luận của bạn', 'comment', '',
                          (value) {
                        context
                            .read<EventDetailWriteCommentBloc>()
                            .add(CommentEvent(value));
                      }),
                    ],
                  ),
                ),
                navigation(
                    () {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        "/newsDetail",
                        (route) => false,
                        arguments: {
                          "route": 1,
                          "id": event.id,
                        },
                      );
                    },
                    BlocProvider.of<EventDetailWriteCommentBloc>(context)
                        .state
                        .comment,
                    () {
                      EventDetailWriteCommentController(context: context)
                          .handleLoadWriteComment(event.id);
                    }),
              ],
            ),
          );
        }));
  }
}
