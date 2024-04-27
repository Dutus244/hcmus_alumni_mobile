import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hcmus_alumni_mobile/model/event.dart';
import 'package:hcmus_alumni_mobile/pages/event_detail/bloc/event_detail_events.dart';
import 'package:hcmus_alumni_mobile/pages/event_detail/bloc/event_detail_states.dart';

import '../../common/values/colors.dart';
import '../../common/widgets/app_bar.dart';
import 'bloc/event_detail_blocs.dart';
import 'event_detail_controller.dart';
import 'widgets/event_detail_widget.dart';

class EventDetail extends StatefulWidget {
  const EventDetail({super.key});

  @override
  State<EventDetail> createState() => _EventDetailState();
}

class _EventDetailState extends State<EventDetail> {
  late Event event;

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic>? args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    var route = 0;
    if (args != null) {
      route = args["route"];
      event = args["event"] as Event;
      EventDetailController(context: context).handleIncreaseView(event.id);
      EventDetailController(context: context).handleGetRelatedEvent();
    }

    return PopScope(
      canPop: false, // prevent back
      onPopInvoked: (_) async {
        Navigator.of(context).pushNamedAndRemoveUntil(
            "/applicationPage", (route) => false,
            arguments: {"route": route, "secondRoute": 1});
      },
      child: BlocBuilder<EventDetailBloc, EventDetailState>(
          builder: (context, state) {
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
                    buildButtonChooseInfoOrParticipant(context, (value) {
                      context.read<EventDetailBloc>().add(PageEvent(value));
                    }),
                    BlocProvider.of<EventDetailBloc>(context).state.page == 0
                        ? detail(context, event)
                        : listParticipant(),
                  ],
                ),
              ),
              // Container nằm dưới cùng của màn hình
              navigation(() {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    "/applicationPage", (route) => false,
                    arguments: {"route": route, "secondRoute": 1});
              }),
            ],
          ),
        );
      }),
    );
  }
}
