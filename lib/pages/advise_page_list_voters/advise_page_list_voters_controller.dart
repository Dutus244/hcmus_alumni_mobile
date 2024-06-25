import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:http/http.dart' as http;

import '../../common/widgets/flutter_toast.dart';
import '../../global.dart';
import '../../model/voter.dart';
import '../../model/voter_response.dart';
import 'bloc/advise_page_list_voters_blocs.dart';
import 'bloc/advise_page_list_voters_events.dart';
import 'bloc/advise_page_list_voters_states.dart';

class AdvisePageListVotersController {
  final BuildContext context;

  const AdvisePageListVotersController({required this.context});

  Future<void> handleLoadVoterData(int page, String postId, int voteId) async {
    if (page == 0) {
      context.read<AdvisePageListVotersBloc>().add(HasReachedMaxVoterEvent(false));
      context.read<AdvisePageListVotersBloc>().add(IndexVoterEvent(1));
    } else {
      if (BlocProvider.of<AdvisePageListVotersBloc>(context).state.hasReachedMaxVoter) {
        return;
      }
      context.read<AdvisePageListVotersBloc>().add(IndexVoterEvent(
          BlocProvider.of<AdvisePageListVotersBloc>(context).state.indexVoter + 1));
    }

    var apiUrl = dotenv.env['API_URL'];
    var endpoint = '/counsel/$postId/votes/$voteId';
    var pageSize = 50;

    var token = Global.storageService.getUserAuthToken();

    var headers = <String, String>{
      'Authorization': 'Bearer $token', // Include bearer token in the headers
    };
    // await Future.delayed(Duration(microseconds: 500));
    try {
      var url = Uri.parse('$apiUrl$endpoint?page=$page&pageSize=$pageSize');

      // Specify UTF-8 encoding for decoding response
      var response = await http.get(url, headers: headers);
      var responseBody = utf8.decode(response.bodyBytes);

      if (response.statusCode == 200) {
        // Convert the JSON string to a Map
        var jsonMap = json.decode(responseBody);
        // Pass the Map to the fromJson method
        var voterResponse = VoterResponse.fromJson(jsonMap);
        if (voterResponse.voters.isEmpty) {
          if (page == 0) {
            context.read<AdvisePageListVotersBloc>().add(VotersEvent(voterResponse.voters));
          }
          context.read<AdvisePageListVotersBloc>().add(HasReachedMaxVoterEvent(true));
          context.read<AdvisePageListVotersBloc>().add(StatusVoterEvent(Status.success));
          return;
        }
        if (page == 0) {
          context.read<AdvisePageListVotersBloc>().add(VotersEvent(voterResponse.voters));
        } else {
          List<Voter> currentList =
              BlocProvider.of<AdvisePageListVotersBloc>(context).state.voters;

          // Create a new list by adding newsResponse.news to the existing list
          List<Voter> updatedNewsList = List.of(currentList)
            ..addAll(voterResponse.voters);

          context.read<AdvisePageListVotersBloc>().add(VotersEvent(updatedNewsList));
        }
        context.read<AdvisePageListVotersBloc>().add(StatusVoterEvent(Status.success));

        if (voterResponse.voters.length < pageSize) {
          context.read<AdvisePageListVotersBloc>().add(HasReachedMaxVoterEvent(true));
        }
      } else {
        // Handle other status codes if needed
        toastInfo(msg: translate('error_get_voters'));
        return;
      }
    } catch (error) {
      // Handle errors
      toastInfo(msg: translate('error_get_voters'));
      return;
    }
  }
}