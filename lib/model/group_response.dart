import 'package:hcmus_alumni_mobile/model/group.dart';

class GroupResponse {
  final List<Group> groups;

  GroupResponse(this.groups);

  GroupResponse.fromJson(Map<String, dynamic> json)
      : groups =
            (json["groups"] as List).map((i) => new Group.fromJson(i)).toList();
}
