import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hcmus_alumni_mobile/model/post.dart';
import 'package:hcmus_alumni_mobile/model/vote.dart';

import '../../common/values/colors.dart';
import 'advise_page_list_voters_controller.dart';
import 'bloc/advise_page_list_voters_blocs.dart';
import 'bloc/advise_page_list_voters_events.dart';
import 'bloc/advise_page_list_voters_states.dart';
import 'widgets/advise_page_list_voters_widget.dart';

class AdvisePageListVoters extends StatefulWidget {
  const AdvisePageListVoters({super.key});

  @override
  State<AdvisePageListVoters> createState() => _AdvisePageListVotersState();
}

class _AdvisePageListVotersState extends State<AdvisePageListVoters> {
  final _scrollController = ScrollController();
  bool _isFetchingData = false;
  late Vote vote;
  late Post post;

  @override
  void initState() {
    super.initState();
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

      AdvisePageListVotersController(context: context).handleLoadVoterData(
          BlocProvider.of<AdvisePageListVotersBloc>(context).state.indexVoter, post.id, vote.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    var profile = 0;
    var route = 0;
    Map<String, dynamic>? args =
    ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    if (args != null) {
      vote = args["vote"];
      post = args["post"];
      if (args["profile"] != null) {
        profile = args["profile"];
      }
      if (profile == 1) {
        route = args["route"];
      }
      // Now you can use the passedValue in your widget
      context
          .read<AdvisePageListVotersBloc>()
          .add(AdvisePageListVotersResetEvent());
      AdvisePageListVotersController(context: context).handleLoadVoterData(0, post.id, vote.id);
    }

    return PopScope(
      canPop: false, // prevent back
      onPopInvoked: (_) async {
        if (profile == 0) {
          Navigator.of(context).pushNamedAndRemoveUntil(
            "/applicationPage",
                (route) => false,
            arguments: {
              "route": 2,
              "secondRoute": 0,
            },
          );
        }
        else {
          Navigator.of(context).pushNamedAndRemoveUntil(
              "/myProfilePage", (route) => false,
              arguments: {"route": route});
        }
      },
      child: BlocBuilder<AdvisePageListVotersBloc, AdvisePageListVotersState>(
          builder: (context, state) {
            return Scaffold(
              appBar: buildAppBar(context, profile, route),
              backgroundColor: AppColors.primaryBackground,
              body: listVoters(context, vote, post, _scrollController),
            );
          }),
    );
  }
}
