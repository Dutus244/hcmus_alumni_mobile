import 'dart:ui';

import 'package:hcmus_alumni_mobile/model/faculty.dart';
import 'package:hcmus_alumni_mobile/model/permissions.dart';
import 'package:hcmus_alumni_mobile/model/picture.dart';
import 'package:hcmus_alumni_mobile/model/picture_response.dart';
import 'package:hcmus_alumni_mobile/model/status.dart';
import 'package:hcmus_alumni_mobile/model/tags.dart';
import 'package:hcmus_alumni_mobile/model/tags_response.dart';
import 'package:hcmus_alumni_mobile/model/vote.dart';
import 'package:hcmus_alumni_mobile/model/vote_response.dart';

import 'creator.dart';

class Post {
  final String id;
  final String title;
  final String content;
  final int childrenCommentNumber;
  final String updateAt;
  final String publishedAt;
  final List<Tags> tags;
  final Status status;
  final Creator creator;
  final List<Picture> pictures;
  late bool isReacted;
  late int reactionCount;
  final Permissions permissions;
  List<Vote> votes;
  String voteSelectedOne;
  List<String> voteSelectedMultiple;
  int totalVote;
  final bool allowMultipleVotes;
  final bool allowAddOptions;

  Post(
      this.id,
      this.title,
      this.content,
      this.childrenCommentNumber,
      this.updateAt,
      this.publishedAt,
      this.tags,
      this.status,
      this.creator,
      this.pictures,
      this.isReacted,
      this.reactionCount,
      this.permissions,
      this.votes,
      this.voteSelectedOne,
      this.voteSelectedMultiple,
      this.totalVote,
      this.allowMultipleVotes,
      this.allowAddOptions);

  Post.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        title = json["title"],
        content = json["content"],
        childrenCommentNumber = json["childrenCommentNumber"].toInt(),
        updateAt = json["updateAt"],
        publishedAt = json["publishedAt"],
        tags = TagsResponse.fromJson(json).tags,
        status = Status.fromJson(json["status"]),
        creator = Creator.fromJson(json["creator"]),
        pictures = PictureResponse.fromJson(json).pictures,
        isReacted = json["isReacted"],
        reactionCount = json["reactionCount"].toInt(),
        permissions = Permissions.fromJson(json['permissions']),
        votes = VoteResponse.fromJson(json).votes,
        voteSelectedOne = VoteResponse.fromJson(json).voteSelectedOne,
        voteSelectedMultiple = VoteResponse.fromJson(json).voteSelectedMultiple,
        totalVote = VoteResponse.fromJson(json).totalVote,
        // allowMultipleVotes = json["allowMultipleVotes"],
        // allowAddOptions = json["allowAddOptions"];
        allowMultipleVotes = true,
        allowAddOptions = true;
}
