part of 'timer_bloc.dart';

abstract class TimerState extends Equatable {
  final int duration;
  final int maxDuration;

  // current value of timer to show to UI

  const TimerState(this.duration, this.maxDuration);

  @override
  List<Object> get props => [duration];
}

class TimerInitialState extends TimerState {
  const TimerInitialState(duration, maxDuration) : super(duration, maxDuration);
}

class TimerRunInProgressState extends TimerState {
  const TimerRunInProgressState(int duration, maxDuration)
      : super(duration, maxDuration);
}

class TimerRunPauseState extends TimerState {
  const TimerRunPauseState(int duration, maxDuration)
      : super(duration, maxDuration);
}

class TimerRunCompleteState extends TimerState {
  // at this state the timer value will be 0
  const TimerRunCompleteState() : super(0, 100);
}
