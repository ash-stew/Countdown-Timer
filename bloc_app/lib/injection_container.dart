// dependency injection inject dependency into objects
// It is a programming pattern which enables us to better organize and manage classes
// and dependencies within our app.

import 'package:bloc_app/counter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'counter_repository.dart';

// GetIt is a service locator, provides a mechanism to access objects from UI
// You have a central registry where can register classes and obtain instances of them

final sl = GetIt.instance; // service locator

// Future- result of an async operation- uncompleted or completed

// Dependency injection can involve I/O operations, so may want to have it operating async
Future init() async {
  // registering the classes (and setting up an object)
  // the => means define single expression in a function
  sl.registerLazySingleton(() => CounterBloc(repo: sl()));
  sl.registerLazySingleton(() => CounterRepository());
}
