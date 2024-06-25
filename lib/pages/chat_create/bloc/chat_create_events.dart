import 'package:hcmus_alumni_mobile/model/inbox.dart';
import 'package:hcmus_alumni_mobile/model/user.dart';

import 'chat_create_states.dart';

abstract class ChatCreateEvent {
  const ChatCreateEvent();
}

class NameEvent extends ChatCreateEvent {
  final String name;

  const NameEvent(this.name);
}

class NameSearchEvent extends ChatCreateEvent {
  final String nameSearch;

  const NameSearchEvent(this.nameSearch);
}

class StatusEvent extends ChatCreateEvent {
  final Status status;

  const StatusEvent(this.status);
}

class UsersEvent extends ChatCreateEvent {
  final List<User> users;

  const UsersEvent(this.users);
}

class IndexUserEvent extends ChatCreateEvent {
  final int indexUser;

  const IndexUserEvent(this.indexUser);
}

class HasReachedMaxUserEvent extends ChatCreateEvent {
  final bool hasReachedMaxUser;

  const HasReachedMaxUserEvent(this.hasReachedMaxUser);
}
