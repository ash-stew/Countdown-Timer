part of 'timer_bloc.dart';

abstract class TimerEvent extends Equatable {
  const TimerEvent();

  @override
  List<Object> get props => [];
}

class TimerStartedEvent extends TimerEvent {
  final int duration;
  const TimerStartedEvent(this.duration);
}

class TimerPausedEvent extends TimerEvent {
  const TimerPausedEvent();
}

class TimerResumedEvent extends TimerEvent {
  final int duration;
  const TimerResumedEvent(this.duration);
}

class TimerResetEvent extends TimerEvent {}

class TimerTickedEvent extends TimerEvent {
  final int duration;
  const TimerTickedEvent(this.duration);

  @override
  List<Object> get props => [duration];
}
