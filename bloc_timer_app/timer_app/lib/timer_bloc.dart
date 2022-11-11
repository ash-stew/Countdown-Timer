import 'package:timer_app/timer_event.dart';
import 'package:timer_app/timer_repository.dart';
import 'package:timer_app/timer_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  final TimerRepository timerRepo;
  int _seconds = 60;

  TimerBloc({required this.timerRepo}) : super(TimerInitialState()) {
    on<DecrementEvent>((event, emit) {
      _seconds--;

      emit(TimerDecrementState());
    });

    on<PauseEvent>((event, emit) {
      _seconds = _seconds;
      emit(TimerPauseState());
    });
  }
}
