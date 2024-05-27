import 'package:hcmus_alumni_mobile/model/creator.dart';
import 'package:hcmus_alumni_mobile/model/permissions.dart';
import 'status.dart';

class Group {
  final String id;
  final String name;
  final Creator creator;
  final String description;
  final String? type;
  final String? coverUrl;
  final String? website;
  final String privacy;
  final Status status;
  final bool isJoined;
  final int participantCount;
  final String createAt;
  final Permissions permissions;
  final String? userRole;
  final bool isRequestPending;

  Group(
      this.id,
      this.name,
      this.creator,
      this.description,
      this.type,
      this.coverUrl,
      this.website,
      this.privacy,
      this.status,
      this.isJoined,
      this.participantCount,
      this.createAt,
      this.permissions,
      this.userRole,
      this.isRequestPending);

  Group.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        name = json["name"],
        creator = Creator.fromJson(json["creator"]),
        description = json["description"],
        type = json["type"],
        coverUrl = json["coverUrl"],
        website = json["website"],
        privacy = json["privacy"],
        status = Status.fromJson(json["status"]),
        isJoined = json["userRole"] == null ? false : true,
        participantCount = json["participantCount"],
        createAt = json["createAt"],
        permissions = Permissions.fromJson(json["permissions"]),
        userRole = json["userRole"],
        isRequestPending = json["isRequestPending"];
}
