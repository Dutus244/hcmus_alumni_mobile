import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hcmus_alumni_mobile/model/event.dart';
import 'package:hcmus_alumni_mobile/pages/event_detail/bloc/event_detail_events.dart';
import 'package:hcmus_alumni_mobile/pages/event_detail/bloc/event_detail_states.dart';

import '../../common/values/colors.dart';
import 'bloc/event_detail_blocs.dart';
import 'event_detail_controller.dart';
import 'widgets/event_detail_widget.dart';

class EventDetail extends StatefulWidget {
  const EventDetail({super.key});

  @override
  State<EventDetail> createState() => _EventDetailState();
}

class _EventDetailState extends State<EventDetail> {
  late PageController pageController; // Không khởi tạo ở đây
  final _scrollController = ScrollController();
  bool _isFetchingData = false;
  late String id;

  @override
  void initState() {
    super.initState();
    // Khởi tạo pageController trong initState
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    if (currentScroll >= (maxScroll * 0.9) && !_isFetchingData) {
      _isFetchingData = true;
      Timer(Duration(seconds: 1), () {
        _isFetchingData = false;
      });

      if (BlocProvider.of<EventDetailBloc>(context).state.page == 1) {
        EventDetailController(context: context).handleGetParticipant(id,
            BlocProvider.of<EventDetailBloc>(context).state.indexParticipant);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic>? args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    if (args != null) {
      id = args["id"];
      EventDetailController(context: context).handleGetEvent(id);
      EventDetailController(context: context).handleGetComment(id, 0);
      EventDetailController(context: context).handleCheckIsParticipated(id);
      EventDetailController(context: context).handleGetParticipant(id, 0);
    }

    return BlocBuilder<EventDetailBloc, EventDetailState>(
        builder: (context, state) {
          return Scaffold(
            appBar: buildAppBar(context),
            backgroundColor: AppColors.primaryBackground,
            body: BlocProvider.of<EventDetailBloc>(context).state.page == 0
                ? detail(
                context,
                BlocProvider.of<EventDetailBloc>(context).state.event,
                _scrollController)
                : listParticipant(context, _scrollController),
          );
        });
  }
}
