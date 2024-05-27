import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../global.dart';
import '../../model/interact.dart';
import '../../model/interact_response.dart';
import 'bloc/list_interact_post_group_blocs.dart';
import 'bloc/list_interact_post_group_states.dart';
import 'bloc/list_interact_post_group_events.dart';
import 'package:http/http.dart' as http;

class ListInteractPostGroupController {
  final BuildContext context;

  const ListInteractPostGroupController({required this.context});

  Future<void> handleGetListInteract(String id, int page) async {
    if (page == 0) {
      context
          .read<ListInteractPostGroupBloc>()
          .add(HasReachedMaxInteractEvent(false));
      context.read<ListInteractPostGroupBloc>().add(IndexInteractEvent(1));
    } else {
      if (BlocProvider.of<ListInteractPostGroupBloc>(context)
          .state
          .hasReachedMaxInteract) {
        return;
      }
      context.read<ListInteractPostGroupBloc>().add(IndexInteractEvent(
          BlocProvider.of<ListInteractPostGroupBloc>(context)
                  .state
                  .indexInteract +
              1));
    }
    var apiUrl = dotenv.env['API_URL'];
    var endpoint = '/groups/$id/react';
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
        if (interactResponse.interact.isEmpty) {
          if (page == 0) {
            context
                .read<ListInteractPostGroupBloc>()
                .add(InteractEvent(interactResponse.interact));
          }
          context
              .read<ListInteractPostGroupBloc>()
              .add(HasReachedMaxInteractEvent(true));
          context
              .read<ListInteractPostGroupBloc>()
              .add(StatusInteractEvent(Status.success));
          return;
        }

        if (page == 0) {
          context
              .read<ListInteractPostGroupBloc>()
              .add(InteractEvent(interactResponse.interact));
        } else {
          List<Interact> currentList =
              BlocProvider.of<ListInteractPostGroupBloc>(context)
                  .state
                  .interact;
          List<Interact> updatedNewsList = List.of(currentList)
            ..addAll(interactResponse.interact);
          context
              .read<ListInteractPostGroupBloc>()
              .add(InteractEvent(updatedNewsList));
        }
        if (interactResponse.interact.length < pageSize) {
          context
              .read<ListInteractPostGroupBloc>()
              .add(HasReachedMaxInteractEvent(true));
        }
        context
            .read<ListInteractPostGroupBloc>()
            .add(StatusInteractEvent(Status.success));
      } else {}
    } catch (error, stacktrace) {}
  }
}
