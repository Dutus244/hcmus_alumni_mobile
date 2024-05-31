import 'interact.dart';

class InteractResponse {
  final List<Interact> interacts;

  InteractResponse(this.interacts);

  InteractResponse.fromJson(Map<String, dynamic> json)
      : interacts= (json["users"] as List).map((i) => new Interact.fromJson(i)).toList();
}