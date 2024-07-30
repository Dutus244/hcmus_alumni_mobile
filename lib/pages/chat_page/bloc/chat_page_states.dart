import 'package:hcmus_alumni_mobile/model/inbox.dart';

enum Status { loading, success }

class ChatPageState {
  final String name;
  final String nameSearch;

  final Status status;
  final List<Inbox> inboxes;
  final int indexInbox;
  final bool hasReachedMaxInbox;

  const ChatPageState({
    this.name = "",
    this.nameSearch = "",
    this.status = Status.loading,
    this.inboxes = const [],
    this.indexInbox = 0,
    this.hasReachedMaxInbox = false,
  });

  ChatPageState copyWith({
    String? name,
    String? nameSearch,
    Status? status,
    List<Inbox>? inboxes,
    int? indexInbox,
    bool? hasReachedMaxInbox,
  }) {
    return ChatPageState(
      name: name ?? this.name,
      nameSearch: nameSearch ?? this.nameSearch,
      status: status ?? this.status,
      inboxes: inboxes ?? this.inboxes,
      indexInbox: indexInbox ?? this.indexInbox,
      hasReachedMaxInbox: hasReachedMaxInbox ?? this.hasReachedMaxInbox,
    );
  }
}
