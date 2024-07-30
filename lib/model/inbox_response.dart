import 'package:hcmus_alumni_mobile/model/inbox.dart';

class InboxResponse {
  final List<Inbox> inboxes;

  InboxResponse(this.inboxes);

  InboxResponse.fromJson(Map<String, dynamic> json)
      : inboxes = (json["inboxes"] as List).map((i) => new Inbox.fromJson(i)).toList();
}