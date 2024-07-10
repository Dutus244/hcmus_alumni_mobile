import 'package:hcmus_alumni_mobile/model/friend_request.dart';

class FriendRequestResponse {
  final List<FriendRequest> requests;

  FriendRequestResponse(this.requests);

  FriendRequestResponse.fromJson(Map<String, dynamic> json)
      : requests = (json["friendRequests"] as List)
            .map((i) => new FriendRequest.fromJson(i))
            .toList();
}
