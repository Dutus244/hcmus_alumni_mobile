import 'package:hcmus_alumni_mobile/model/hall_of_fame.dart';

class HofDetailState {
  final HallOfFame? hallOfFame;

  HofDetailState({this.hallOfFame = null});

  HofDetailState copyWith({HallOfFame? hallOfFame}) {
    return HofDetailState(hallOfFame: hallOfFame ?? this.hallOfFame);
  }
}
