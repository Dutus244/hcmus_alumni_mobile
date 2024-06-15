import 'package:hcmus_alumni_mobile/model/friend_suggestion.dart';

class FriendSuggestionResponse {
  final List<FriendSuggestion> suggestions;

  FriendSuggestionResponse(this.suggestions);

  FriendSuggestionResponse.fromJson(Map<String, dynamic> json)
      : suggestions = (json["friends"] as List)
      .map((i) => new FriendSuggestion.fromJson(i))
      .toList();
}