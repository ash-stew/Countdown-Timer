import 'package:get_it/get_it.dart';
import 'package:timer_app/timer_bloc.dart';
import 'package:timer_app/timer_repository.dart';

final s1 = GetIt.instance;

Future init() async {
  s1.registerLazySingleton(() => TimerBloc(timerRepo: s1()));
  s1.registerLazySingleton(() => TimerRepository());
}
