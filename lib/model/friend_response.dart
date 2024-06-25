import 'package:hcmus_alumni_mobile/model/friend.dart';

class FriendResponse {
  final List<Friend> friends;

  FriendResponse(this.friends);

  FriendResponse.fromJson(Map<String, dynamic> json)
      : friends = (json["friends"] as List)
            .map((i) => new Friend.fromJson(i))
            .toList();
}
