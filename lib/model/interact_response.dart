import 'interact.dart';

class InteractResponse {
  final List<Interact> interact;

  InteractResponse(this.interact);

  InteractResponse.fromJson(Map<String, dynamic> json)
      : interact = (json["users"] as List).map((i) => new Interact.fromJson(i)).toList();
}