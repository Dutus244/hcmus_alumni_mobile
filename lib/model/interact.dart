import 'package:hcmus_alumni_mobile/model/react.dart';
import 'package:hcmus_alumni_mobile/model/user.dart';

class Interact {
  final User creator;
  final React react;

  Interact(
    this.creator,
    this.react,
  );

  Interact.fromJson(Map<String, dynamic> json)
      : creator = User.fromJson(json["creator"]),
        react = React.fromJson(json["react"]);
}
