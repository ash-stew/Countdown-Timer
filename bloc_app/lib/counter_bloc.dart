import 'package:bloc_app/counter_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'counter_state.dart';
import 'counter_repository.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  final CounterRepository repo;
  int _counter = 0;

  // Constructor with a CounterRepo being mandatory arguement
  // super will call the constructor of the base class- CounterInitialState.
  CounterBloc({required this.repo}) : super(CounterInitialState()) {
    // registering the events
    on<IncrementEvent>((event, emit) {
      _counter++;
      // emitting a new state- we want bloc to handle a new event
      emit(CounterIncrementState(repo.getTensAndOnes(_counter)));
    });

    on<DecrementEvent>((event, emit) {
      _counter--;
      // emitting a new state- we want bloc to handle a new event
      emit(CounterDecrementState(repo.getTensAndOnes(_counter)));
    });
  }
}
