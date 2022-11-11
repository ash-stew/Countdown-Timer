import 'dart:developer';

abstract class CounterEvent {} // base class subsequent inc/dec events inherit.

// these two events will be passed into the bloc
class IncrementEvent extends CounterEvent {}

class DecrementEvent extends CounterEvent {}

class ColorEvent extends CounterEvent {}
