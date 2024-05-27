import 'package:hcmus_alumni_mobile/model/request_group.dart';

class RequestGroupResponse {
  final List<RequestGroup> request;

  RequestGroupResponse(this.request);

  RequestGroupResponse.fromJson(Map<String, dynamic> json)
      : request = (json["requests"] as List)
            .map((i) => new RequestGroup.fromJson(i))
            .toList();
}
