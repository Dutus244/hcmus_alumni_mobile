import 'package:hcmus_alumni_mobile/model/group.dart';

class GroupResponse {
  final List<Group> group;

  GroupResponse(this.group);

  GroupResponse.fromJson(Map<String, dynamic> json)
      : group =
            (json["groups"] as List).map((i) => new Group.fromJson(i)).toList();
}
