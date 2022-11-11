import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:equatable/equatable.dart';

@immutable
abstract class TimerState extends Equatable  {
  final int duration;

  TimerState(this.duration, [List props = const []])
      : super([duration]..addAll(props));
}

class TimerReadyState extends TimerState {
  TimerReadyState(int duration) : super(duration);

  @override
  String toString() => 'Ready {duration: $duration }';
}

class TimerPausedState extends TimerState {
  TimerPausedState(int duration) : super(duration);

  @override
  String toString() => 'Paused {duration: $duration}';
}

class TimerRunningState extends TimerState {
  TimerRunningState(int duration) : super(duration);

  @override
  String toString() => 'Running {duration: $duration}';
}

class TimerFinishedState extends TimerState {
  TimerFinishedState() : super(0);

  @override
  String toString() => 'Finished';
}

/*

abstract class TimerState {}

class TimerInitialState extends TimerState {}

class TimerDecrementState extends TimerState {}

class TimerPauseState extends TimerState {}

class TimerElapsedState extends TimerState {}

*/