abstract class ApplicationPageEvent {
  const ApplicationPageEvent();
}

class TriggerApplicationPageEvent extends ApplicationPageEvent {
  final int index;

  const TriggerApplicationPageEvent(this.index) : super();
}
