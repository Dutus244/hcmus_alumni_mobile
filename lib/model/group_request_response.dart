import 'package:hcmus_alumni_mobile/model/group_request.dart';

class GroupRequestResponse {
  final List<GroupRequest> requests;

  GroupRequestResponse(this.requests);

  GroupRequestResponse.fromJson(Map<String, dynamic> json)
      : requests = (json["requests"] as List)
            .map((i) => new GroupRequest.fromJson(i))
            .toList();
}
