import 'package:hcmus_alumni_mobile/model/creator.dart';
import 'status.dart';

class Group {
  final String id;
  final String name;
  final Creator creator;
  final String description;
  final String? type;
  final String? avatarUrl;
  final String? coverUrl;
  final String? website;
  final String privacy;
  final Status status;
  final bool isJoined;
  final int participantCount;
  final String createAt;

  Group(
      this.id,
      this.name,
      this.creator,
      this.description,
      this.type,
      this.avatarUrl,
      this.coverUrl,
      this.website,
      this.privacy,
      this.status,
      this.isJoined,
      this.participantCount,
      this.createAt);

  Group.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        name = json["name"],
        creator = Creator.fromJson(json["creator"]),
        description = 'Group là nơi học tập kiến thức, chia sẻ kinh nghiệm và trao đổi chuyên môn của những con người yêu thích và đam mê công nghệ',
        type = json["type"],
        avatarUrl = json["avatarUrl"],
        coverUrl = json["coverUrl"],
        website = json["website"],
        privacy = json["privacy"],
        status = Status.fromJson(json["status"]),
        isJoined = true,
        participantCount = 2000,
        createAt = '2024-04-10 20:29:15';
}
