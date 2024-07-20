import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:hcmus_alumni_mobile/model/achievement.dart';
import 'package:hcmus_alumni_mobile/model/achievement_response.dart';
import 'package:hcmus_alumni_mobile/model/education.dart';
import 'package:hcmus_alumni_mobile/model/education_response.dart';
import 'package:hcmus_alumni_mobile/model/job_response.dart';
import 'package:intl/intl.dart';

import '../../common/widgets/flutter_toast.dart';
import '../../global.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import '../../model/alumni.dart';
import '../../model/alumni_verification.dart';
import '../../model/job.dart';
import '../../model/user.dart';
import 'bloc/my_profile_edit_blocs.dart';
import 'bloc/my_profile_edit_events.dart';

class MyProfileEditController {
  final BuildContext context;

  const MyProfileEditController({required this.context});

  Future<void> handleGetProfile() async {
    var token = Global.storageService.getUserAuthToken();
    var url = Uri.parse(
        '${dotenv.env['API_URL']}/user/${Global.storageService.getUserId()}/profile');
    var headers = <String, String>{
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
    try {
      var response = await http.get(url, headers: headers);
      var responseBody = utf8.decode(response.bodyBytes);
      if (response.statusCode == 200) {
        var jsonMap = json.decode(responseBody);
        print(jsonMap);
        var user = User.fromJson(jsonMap["user"]);
        context.read<MyProfileEditBloc>().add(UpdateProfileEvent(user));
        if (jsonMap["alumniVerification"] != null) {
          var alumniVerification =
              AlumniVerification.fromJson(jsonMap["alumniVerification"]);
          context
              .read<MyProfileEditBloc>()
              .add(UpdateAlumniVerEvent(alumniVerification));
        } else {
          context.read<MyProfileEditBloc>().add(StatusEvent("UNSENT"));
        }
        if (jsonMap["alumni"] != null) {
          var alumni =
          Alumni.fromJson(jsonMap["alumni"]);
          context
              .read<MyProfileEditBloc>()
              .add(UpdateAlumniEvent(alumni));
        }
      }
    } catch (error) {
      print(error);
    }
  }

  Future<void> handleGetJob() async {
    var token = Global.storageService.getUserAuthToken();
    var url = Uri.parse(
        '${dotenv.env['API_URL']}/user/${Global.storageService.getUserId()}/profile/job');
    var headers = <String, String>{
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
    try {
      var response = await http.get(url, headers: headers);
      var responseBody = utf8.decode(response.bodyBytes);
      if (response.statusCode == 200) {
        var jsonMap = json.decode(responseBody);
        var jobResponse = JobResponse.fromJson(jsonMap);
        context.read<MyProfileEditBloc>().add(JobsEvent(jobResponse.jobs));
      }
    } catch (error) {
      print(error);
    }
  }

  Future<void> handleGetEducation() async {
    var token = Global.storageService.getUserAuthToken();
    var url = Uri.parse(
        '${dotenv.env['API_URL']}/user/${Global.storageService.getUserId()}/profile/education');
    var headers = <String, String>{
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
    try {
      var response = await http.get(url, headers: headers);
      var responseBody = utf8.decode(response.bodyBytes);
      if (response.statusCode == 200) {
        var jsonMap = json.decode(responseBody);
        var educationResponse = EducationResponse.fromJson(jsonMap);
        context
            .read<MyProfileEditBloc>()
            .add(EducationsEvent(educationResponse.educations));
      }
    } catch (error) {
      print(error);
    }
  }

  Future<void> handleGetAchievement() async {
    var token = Global.storageService.getUserAuthToken();
    var url = Uri.parse(
        '${dotenv.env['API_URL']}/user/${Global.storageService.getUserId()}/profile/achievement');
    var headers = <String, String>{
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
    try {
      var response = await http.get(url, headers: headers);
      var responseBody = utf8.decode(response.bodyBytes);
      if (response.statusCode == 200) {
        var jsonMap = json.decode(responseBody);
        var achievementResponse = AchievementResponse.fromJson(jsonMap);
        context
            .read<MyProfileEditBloc>()
            .add(AchievementsEvent(achievementResponse.achievements));
      }
    } catch (error) {
      print(error);
    }
  }

  Future<void> handleChangeAvatar(File? avatar) async {
    var apiUrl = dotenv.env['API_URL'];
    var endpoint = '/user/profile/avatar';
    var token = Global.storageService.getUserAuthToken();

    var headers = <String, String>{
      'Authorization': 'Bearer $token',
      "Content-Type": "application/json" // Include bearer token in the headers
    };

    var request = http.MultipartRequest('PUT', Uri.parse('$apiUrl$endpoint'));
    request.headers.addAll(headers);

    request.files.add(
      http.MultipartFile(
        'avatar',
        avatar!.readAsBytes().asStream(),
        avatar.lengthSync(),
        filename: avatar.toString(),
        contentType: MediaType('image', 'jpeg'),
      ),
    );

    try {
      // Send the request
      var streamedResponse = await request.send();

      // Convert the streamed response to a regular HTTP response
      var response = await http.Response.fromStream(streamedResponse);
      if (response.statusCode == 200) {}
    } catch (e) {
      // Exception occurred
      toastInfo(msg: translate('error_verify_alumni'));
      return;
    }
  }

  Future<void> handleChangeCover(File? cover) async {
    var apiUrl = dotenv.env['API_URL'];
    var endpoint = '/user/profile/cover';
    var token = Global.storageService.getUserAuthToken();

    var headers = <String, String>{
      'Authorization': 'Bearer $token',
      "Content-Type": "application/json" // Include bearer token in the headers
    };

    var request = http.MultipartRequest('PUT', Uri.parse('$apiUrl$endpoint'));
    request.headers.addAll(headers);

    request.files.add(
      http.MultipartFile(
        'cover',
        cover!.readAsBytes().asStream(),
        cover.lengthSync(),
        filename: cover.toString(),
        contentType: MediaType('image', 'jpeg'),
      ),
    );

    try {
      // Send the request
      var streamedResponse = await request.send();

      // Convert the streamed response to a regular HTTP response
      var response = await http.Response.fromStream(streamedResponse);
      if (response.statusCode == 200) {}
    } catch (e) {
      // Exception occurred
      toastInfo(msg: translate('error_verify_alumni'));
      return;
    }
  }

  Future<void> handleSaveProfile() async {
    final state = context.read<MyProfileEditBloc>().state;
    String fullName = state.fullName;
    int facultyId = state.facultyId;
    int sexId = state.sex == "Nam" ? 1 : 2;
    String socialMediaLink = state.socialLink;
    String phone = state.phone;
    String aboutMe = state.aboutMe;
    String classs = state.classs;
    String graduationYear = state.endYear;
    String dob = state.dob;

    var apiUrl = dotenv.env['API_URL'];
    var endpoint = '/user/profile';
    var token = Global.storageService.getUserAuthToken();

    var headers = <String, String>{
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json' // Include bearer token in the headers
    };

    var body = json.encode({
      'user': {
        'fullName': fullName,
        'facultyId': facultyId,
        'sexId': sexId,
        'socialMediaLink': socialMediaLink,
        'phone': phone,
        'aboutMe': aboutMe,
        'dob': dob == "" ? "" : DateFormat('yyyy-MM-dd').format(DateFormat('dd/MM/yyyy')
            .parse(dob))
      },
      'alumni': {
        'alumClass': classs,
        'graduationYear':
            graduationYear != "" ? int.parse(graduationYear) : 0,
      },
    });

    print(body);

    try {
      // Send the request
      var response = await http.put(
        Uri.parse('$apiUrl$endpoint'),
        headers: headers,
        body: body,
      );
      print(response.body);
      if (response.statusCode == 200) {
        toastInfo(msg: translate('saved_successfully'));
      } else {
        toastInfo(msg: translate('error_verify_alumni'));
      }
    } catch (e) {
      // Exception occurred
      print(e);
      toastInfo(msg: translate('error_verify_alumni'));
      return;
    }
  }

  Future<void> handleAlumniVerification() async {
    final state = context.read<MyProfileEditBloc>().state;
    String studentId = state.studentId;
    int beginningYear = state.startYear != "" ? int.parse(state.startYear) : 0;
    String socialMediaLink = state.socialLink;
    int facultyId = state.facultyId;
    String fullName = state.fullName;

    if (fullName.isEmpty) {
      toastInfo(msg: translate('must_fill_full_name'));
      return;
    }

    var apiUrl = dotenv.env['API_URL'];
    var endpoint = '/user/alumni-verification';

    var token = Global.storageService.getUserAuthToken();

    var headers = <String, String>{
      'Authorization': 'Bearer $token',
      "Content-Type": "application/json" // Include bearer token in the headers
    };

    var request = http.MultipartRequest('POST', Uri.parse('$apiUrl$endpoint'));
    request.headers.addAll(headers);
    request.fields['fullName'] = fullName;
    request.fields['facultyId'] = facultyId.toString();
    request.fields['studentId'] = studentId;
    request.fields['beginningYear'] = beginningYear.toString();
    request.fields['socialMediaLink'] = socialMediaLink;

    try {
      // Send the request
      var streamedResponse = await request.send();

      // Convert the streamed response to a regular HTTP response
      var response = await http.Response.fromStream(streamedResponse);
      print(response.body);
      if (response.statusCode == 201) {
        handleGetProfile();
      } else {

      }
    } catch (e) {
      // Exception occurred
      toastInfo(msg: translate('error_verify_alumni'));
      return;
    }
  }

  Future<bool> handleDeleteJob(Job job) async {
    var apiUrl = dotenv.env['API_URL'];
    var endpoint = '/user/profile/job/${job.id}';
    var token = Global.storageService.getUserAuthToken();

    var headers = <String, String>{
      'Authorization': 'Bearer $token',
      "Content-Type": "application/json" // Include bearer token in the headers
    };

    var body = json.encode({
      'companyName': job.companyName,
      'position': job.position,
      'startTime': job.startTime != ""
          ? DateFormat('yyyy-MM-dd')
          .format(DateFormat('dd/MM/yyyy').parse(job.startTime))
          : "",
      'endTime': job.endTime != ""
          ? DateFormat('yyyy-MM-dd')
          .format(DateFormat('dd/MM/yyyy').parse(job.endTime))
          : "",
      'isWorking': job.isWorking,
      'privacy': 'PUBLIC',
      'isDelete': 1,
    });

    try {
      // Send the request
      var response = await http.put(
        Uri.parse('$apiUrl$endpoint'),
        headers: headers,
        body: body,
      );
      if (response.statusCode == 200) {
        MyProfileEditController(context: context).handleGetJob();
        return true;
      } else {
        toastInfo(msg: translate('error_verify_alumni'));
        return false;
      }
    } catch (e) {
      // Exception occurred
      toastInfo(msg: translate('error_verify_alumni'));
      print(e);
      return false;
    }
  }

  Future<bool> handleDeleteEducation(Education education) async {
    var apiUrl = dotenv.env['API_URL'];
    var endpoint = '/user/profile/education/${education.id}';
    var token = Global.storageService.getUserAuthToken();

    var headers = <String, String>{
      'Authorization': 'Bearer $token',
      "Content-Type": "application/json" // Include bearer token in the headers
    };

    var body = json.encode({
      'schoolName': education.schoolName,
      'degree': education.degree,
      'startTime': education.startTime != ""
          ? DateFormat('yyyy-MM-dd').format(DateFormat('dd/MM/yyyy')
          .parse(education.startTime).add(Duration(days: 1))
      )
          : "",
      'endTime': education.endTime != ""
          ? DateFormat('yyyy-MM-dd').format(DateFormat('dd/MM/yyyy')
          .parse(education.endTime).add(Duration(days: 1))
      )
          : "",
      'isLearning': education.isLearning,
      'privacy': 'PUBLIC',
      'isDelete': 1,
    });

    try {
      // Send the request
      var response = await http.put(
        Uri.parse('$apiUrl$endpoint'),
        headers: headers,
        body: body,
      );
      if (response.statusCode == 200) {
        MyProfileEditController(context: context).handleGetEducation();
        return true;
      } else {
        toastInfo(msg: translate('error_verify_alumni'));
        return false;
      }
    } catch (e) {
      // Exception occurred
      toastInfo(msg: translate('error_verify_alumni'));
      print(e);
      return false;
    }
  }

  Future<bool> handleDeleteAchievement(Achievement achievement) async {
    var apiUrl = dotenv.env['API_URL'];
    var endpoint = '/user/profile/achievement/${achievement.id}';
    var token = Global.storageService.getUserAuthToken();

    var headers = <String, String>{
      'Authorization': 'Bearer $token',
      "Content-Type": "application/json" // Include bearer token in the headers
    };

    var body = json.encode({
      'achievementName': achievement.name,
      'achievementType': achievement.type,
      'achievementTime': achievement.time != ""
          ? DateFormat('yyyy-MM-dd')
          .format(DateFormat('dd/MM/yyyy').parse(achievement.time))
          : "",
      'privacy': 'PUBLIC',
      'isDelete': 1,
    });

    try {
      // Send the request
      var response = await http.put(
        Uri.parse('$apiUrl$endpoint'),
        headers: headers,
        body: body,
      );
      if (response.statusCode == 200) {
        MyProfileEditController(context: context).handleGetAchievement();
        return true;
      } else {
        toastInfo(msg: translate('error_verify_alumni'));
        return false;
      }
    } catch (e) {
      // Exception occurred
      toastInfo(msg: translate('error_verify_alumni'));
      print(e);
      return false;
    }
  }
}
