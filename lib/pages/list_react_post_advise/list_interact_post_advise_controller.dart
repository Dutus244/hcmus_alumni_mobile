import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hcmus_alumni_mobile/pages/list_react_post_advise/bloc/list_interact_post_advise_events.dart';

import '../../global.dart';
import '../../model/interact.dart';
import '../../model/interact_response.dart';
import 'bloc/list_interact_post_advise_blocs.dart';
import 'bloc/list_interact_post_advise_states.dart';
import 'package:http/http.dart' as http;

class ListInteractPostAdviseController {
  final BuildContext context;

  const ListInteractPostAdviseController({required this.context});

  Future<void> handleGetListInteract(String id, int page) async {
    if (page == 0) {
      context
          .read<ListInteractPostAdviseBloc>()
          .add(HasReachedMaxInteractEvent(false));
      context.read<ListInteractPostAdviseBloc>().add(IndexInteractEvent(1));
    } else {
      if (BlocProvider.of<ListInteractPostAdviseBloc>(context)
          .state
          .hasReachedMaxInteract) {
        return;
      }
      context.read<ListInteractPostAdviseBloc>().add(IndexInteractEvent(
          BlocProvider.of<ListInteractPostAdviseBloc>(context)
                  .state
                  .indexInteract +
              1));
    }
    var apiUrl = dotenv.env['API_URL'];
    var endpoint = '/counsel/$id/react';
    var pageSize = 10;
    var token = Global.storageService.getUserAuthToken();

    var headers = <String, String>{
      'Authorization': 'Bearer $token',
    };
    try {
      var url =
          Uri.parse('$apiUrl$endpoint?reactId=1&page=$page&pageSize=$pageSize');
      var response = await http.get(url, headers: headers);
      var responseBody = utf8.decode(response.bodyBytes);
      if (response.statusCode == 200) {
        var jsonMap = json.decode(responseBody);
        var interactResponse = InteractResponse.fromJson(jsonMap);
        if (interactResponse.interacts.isEmpty) {
          if (page == 0) {
            context
                .read<ListInteractPostAdviseBloc>()
                .add(InteractsEvent(interactResponse.interacts));
          }
          context
              .read<ListInteractPostAdviseBloc>()
              .add(HasReachedMaxInteractEvent(true));
          context
              .read<ListInteractPostAdviseBloc>()
              .add(StatusInteractEvent(Status.success));
          return;
        }

        if (page == 0) {
          context
              .read<ListInteractPostAdviseBloc>()
              .add(InteractsEvent(interactResponse.interacts));
        } else {
          List<Interact> currentList =
              BlocProvider.of<ListInteractPostAdviseBloc>(context)
                  .state
                  .interacts;
          List<Interact> updatedNewsList = List.of(currentList)
            ..addAll(interactResponse.interacts);
          context
              .read<ListInteractPostAdviseBloc>()
              .add(InteractsEvent(updatedNewsList));
        }
        if (interactResponse.interacts.length < pageSize) {
          context
              .read<ListInteractPostAdviseBloc>()
              .add(HasReachedMaxInteractEvent(true));
        }
        context
            .read<ListInteractPostAdviseBloc>()
            .add(StatusInteractEvent(Status.success));
      } else {}
    } catch (error) {}
  }
}
