import 'package:bloc_app/counter_repository.dart';

abstract class CounterState {}

class CounterIncrementState extends CounterState {
  final TensAndOnes tensAndOnes;

  CounterIncrementState(this.tensAndOnes);
}

class CounterDecrementState extends CounterState {
  final TensAndOnes tensAndOnes;

  CounterDecrementState(this.tensAndOnes);
}

class CounterInitialState extends CounterState {}
