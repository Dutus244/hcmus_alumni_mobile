import 'package:hcmus_alumni_mobile/model/inbox.dart';

import 'chat_page_states.dart';

abstract class ChatPageEvent {
  const ChatPageEvent();
}

class NameEvent extends ChatPageEvent {
  final String name;

  const NameEvent(this.name);
}

class NameSearchEvent extends ChatPageEvent {
  final String nameSearch;

  const NameSearchEvent(this.nameSearch);
}

class StatusEvent extends ChatPageEvent {
  final Status status;

  const StatusEvent(this.status);
}

class InboxesEvent extends ChatPageEvent {
  final List<Inbox> inboxes;

  const InboxesEvent(this.inboxes);
}

class IndexInboxEvent extends ChatPageEvent {
  final int indexInbox;

  const IndexInboxEvent(this.indexInbox);
}

class HasReachedMaxInboxEvent extends ChatPageEvent {
  final bool hasReachedMaxInbox;

  const HasReachedMaxInboxEvent(this.hasReachedMaxInbox);
}
