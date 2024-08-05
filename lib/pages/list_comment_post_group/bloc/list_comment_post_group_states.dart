import 'package:hcmus_alumni_mobile/model/comment.dart';

enum Status { loading, success }

class ListCommentPostGroupState {
  final Status statusComment;
  final List<Comment> comments;
  final int indexComment;
  final bool hasReachedMaxComment;
  final String content;
  final Comment? children;
  final int reply;
  final bool isLoading;

  ListCommentPostGroupState(
      {this.statusComment = Status.loading,
      this.comments = const [],
      this.indexComment = 0,
      this.hasReachedMaxComment = false,
      this.content = "",
      this.children = null,
      this.reply = 0,
      this.isLoading = false});

  ListCommentPostGroupState copyWith(
      {Status? statusComment,
      List<Comment>? comments,
      int? indexComment,
      bool? hasReachedMaxComment,
      String? content,
      Comment? children,
      int? reply,
      bool? isLoading}) {
    return ListCommentPostGroupState(
      statusComment: statusComment ?? this.statusComment,
      comments: comments ?? this.comments,
      indexComment: indexComment ?? this.indexComment,
      hasReachedMaxComment: hasReachedMaxComment ?? this.hasReachedMaxComment,
      content: content ?? this.content,
      children: children ?? this.children,
      reply: reply ?? this.reply,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
