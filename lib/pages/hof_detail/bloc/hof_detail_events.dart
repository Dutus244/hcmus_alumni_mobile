import 'package:hcmus_alumni_mobile/model/hall_of_fame.dart';

class HofDetailEvent {
  const HofDetailEvent();
}

class HofEvent extends HofDetailEvent {
  final HallOfFame hallOfFame;

  const HofEvent(this.hallOfFame);
}
