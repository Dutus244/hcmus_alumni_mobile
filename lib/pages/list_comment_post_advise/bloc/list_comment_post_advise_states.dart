import 'package:hcmus_alumni_mobile/model/comment.dart';

enum Status { loading, success }

class ListCommentPostAdviseState {
  final Status statusComment;
  final List<Comment> comments;
  final int indexComment;
  final bool hasReachedMaxComment;
  final String content;
  final Comment? children;
  final int reply;

  ListCommentPostAdviseState(
      {this.statusComment = Status.loading,
      this.comments = const [],
      this.indexComment = 0,
      this.hasReachedMaxComment = false,
      this.content = "",
      this.children = null,
      this.reply = 0});

  ListCommentPostAdviseState copyWith(
      {Status? statusComment,
      List<Comment>? comments,
      int? indexComment,
      bool? hasReachedMaxComment,
      String? content,
      Comment? children,
      int? reply}) {
    return ListCommentPostAdviseState(
      statusComment: statusComment ?? this.statusComment,
      comments: comments ?? this.comments,
      indexComment: indexComment ?? this.indexComment,
      hasReachedMaxComment: hasReachedMaxComment ?? this.hasReachedMaxComment,
      content: content ?? this.content,
      children: children ?? this.children,
      reply: reply ?? this.reply,
    );
  }
}
