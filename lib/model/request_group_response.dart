import 'package:hcmus_alumni_mobile/model/request_group.dart';

class RequestGroupResponse {
  final List<RequestGroup> requests;

  RequestGroupResponse(this.requests);

  RequestGroupResponse.fromJson(Map<String, dynamic> json)
      : requests = (json["requests"] as List)
            .map((i) => new RequestGroup.fromJson(i))
            .toList();
}
