import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hcmus_alumni_mobile/model/hall_of_fame.dart';
import 'package:hcmus_alumni_mobile/pages/hof_page/bloc/hof_page_events.dart';
import 'package:hcmus_alumni_mobile/pages/hof_page/bloc/hof_page_states.dart';

import '../../global.dart';
import '../../model/hall_of_fame_response.dart';
import 'bloc/hof_page_blocs.dart';
import 'package:http/http.dart' as http;

class HofPageController {
  final BuildContext context;

  const HofPageController({required this.context});

  Future<void> handleSearchHof() async {
    final state = context.read<HofPageBloc>().state;
    String name = state.name;
    String faculty = state.faculty;
    String beginningYear = state.beginningYear;
    context.read<HofPageBloc>().add(ClearResultEvent());
    context.read<HofPageBloc>().add(NameSearchEvent(name));
    context.read<HofPageBloc>().add(FacultySearchEvent(faculty));
    context.read<HofPageBloc>().add(BeginningYearSearchEvent(beginningYear));
    await Future.delayed(Duration(milliseconds: 100));
    handleLoadHofData(0);
  }

  Future<void> handleLoadHofData(int page) async {
    if (page == 0) {
      context.read<HofPageBloc>().add(HasReachedMaxHofEvent(false));
      context.read<HofPageBloc>().add(IndexHofEvent(1));
    } else {
      if (BlocProvider.of<HofPageBloc>(context).state.hasReachedMaxHof) {
        return;
      }
      context.read<HofPageBloc>().add(IndexHofEvent(
          BlocProvider.of<HofPageBloc>(context).state.indexHof + 1));
    }
    final state = context.read<HofPageBloc>().state;
    String name = state.nameSearch;
    String faculty = state.facultySearch;
    String beginningYear = state.beginningYearSearch;
    String facultyId = "";

    switch (faculty) {
      case "Công nghệ thông tin":
        facultyId = "1";
      case "Vật lý – Vật lý kỹ thuật":
        facultyId = "2";
      case "Địa chất":
        facultyId = "3";
      case "Toán – Tin học":
        facultyId = "4";
      case "Điện tử - Viễn thông":
        facultyId = "5";
      case "Khoa học & Công nghệ Vật liệu":
        facultyId = "6";
      case "Hóa học":
        facultyId = "7";
      case "Sinh học – Công nghệ Sinh học":
        facultyId = "8";
      case "Môi trường":
        facultyId = "9";
    }

    var apiUrl = dotenv.env['API_URL'];
    var endpoint = '/hof';
    var pageSize = 5;

    var token = Global.storageService.getUserAuthToken();

    var headers = <String, String>{
      'Authorization': 'Bearer $token', // Include bearer token in the headers
    };
    // await Future.delayed(Duration(microseconds: 500));
    try {
      var url = Uri.parse(
          '$apiUrl$endpoint?page=$page&pageSize=$pageSize&title=$name&facultyId=$facultyId&beginningYear=$beginningYear');

      // Specify UTF-8 encoding for decoding response
      var response = await http.get(url, headers: headers);
      var responseBody = utf8.decode(response.bodyBytes);
      if (response.statusCode == 200) {
        // Convert the JSON string to a Map
        var jsonMap = json.decode(responseBody);
        // Pass the Map to the fromJson method
        var hallOfFameResponse = HallOfFameResponse.fromJson(jsonMap);
        if (hallOfFameResponse.hallOfFames.isEmpty) {
          if (page == 0) {
            context
                .read<HofPageBloc>()
                .add(HallOfFamesEvent(hallOfFameResponse.hallOfFames));
          }
          context.read<HofPageBloc>().add(HasReachedMaxHofEvent(true));
          context.read<HofPageBloc>().add(StatusHofEvent(Status.success));
          return;
        }
        if (page == 0) {
          context
              .read<HofPageBloc>()
              .add(HallOfFamesEvent(hallOfFameResponse.hallOfFames));
        } else {
          List<HallOfFame> currentList =
              BlocProvider.of<HofPageBloc>(context).state.hallOfFames;

          // Create a new list by adding newsResponse.news to the existing list
          List<HallOfFame> updatedNewsList = List.of(currentList)
            ..addAll(hallOfFameResponse.hallOfFames);

          context.read<HofPageBloc>().add(HallOfFamesEvent(updatedNewsList));
        }
        context.read<HofPageBloc>().add(StatusHofEvent(Status.success));

        if (hallOfFameResponse.hallOfFames.length < pageSize) {
          context.read<HofPageBloc>().add(HasReachedMaxHofEvent(true));
        }
      } else {
        // Handle other status codes if needed
      }
    } catch (error) {
      // Handle errors
    }
  }
}
