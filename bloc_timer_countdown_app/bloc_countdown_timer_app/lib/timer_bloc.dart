import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:bloc_countdown_timer_app/ticker.dart';

part 'timer_event.dart';
part 'timer_state.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  final Ticker _ticker;
  static const _duration = 5;

  // to listen to ticker stream
  StreamSubscription<int>? _tickerSubscription;

  TimerBloc({required Ticker ticker})
      : _ticker = ticker,
        // specifying the initial stage
        super(const TimerInitialState(_duration, _duration)) {
    on<TimerStartedEvent>(_onStarted);
    on<TimerTickedEvent>(_onTicked);
    on<TimerPausedEvent>(_onPaused);
    on<TimerResumedEvent>(_onResumed);
    on<TimerResetEvent>(_onReset);
  }

  @override
  Future<void> close() {
    _tickerSubscription?.cancel();
    return super.close();
  }

  void _onStarted(TimerStartedEvent event, Emitter<TimerState> emit) {
    // If a subscrition already exists, then we need to cancel it
    _tickerSubscription?.cancel();

    // invoke the TimerRunInProgress state
    emit(TimerRunInProgressState(event.duration, _duration));
    // making the subscription listen to TimerTicked state
    _tickerSubscription = _ticker
        .tick(ticks: event.duration)
        .listen((duration) => add(TimerTickedEvent(duration)));
  }

  void _onTicked(TimerTickedEvent event, Emitter<TimerState> emit) {
    emit(event.duration > 0
        ? TimerRunInProgressState(
            event.duration, _duration) // invoke RunInProgress state
        : const TimerRunCompleteState()); // invoke TimerRunComplete state
  }

  void _onPaused(TimerPausedEvent event, Emitter<TimerState> emit) {
    // if the timer is paused, we will also pause the subscription
    _tickerSubscription?.pause();
    emit(TimerRunPauseState(
        state.duration, _duration)); // Invoke TimerRunPause state
  }

  void _onResumed(TimerResumedEvent event, Emitter<TimerState> emit) {
    // as the timer resumes, the subscription will resume also
    _tickerSubscription?.resume();
    emit(TimerRunInProgressState(
        state.duration, _duration)); // invoke runInProgress state
  }

  void _onReset(TimerResetEvent event, Emitter<TimerState> emit) {
    // Timer counting completed, so we must cancel subscroption.
    _tickerSubscription?.cancel();
    emit(const TimerInitialState(_duration, _duration));
  }
}
