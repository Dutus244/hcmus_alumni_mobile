import 'package:hcmus_alumni_mobile/model/creator.dart';
import 'package:hcmus_alumni_mobile/model/react.dart';

class Interact {
  final Creator creator;
  final React react;

  Interact(
    this.creator,
    this.react,
  );

  Interact.fromJson(Map<String, dynamic> json)
      : creator = Creator.fromJson(json["creator"]),
        react = React.fromJson(json["react"]);
}
