import 'package:bloc_countdown_timer_app/shared_ui/animated_widgets/animated_dinosaur.dart';
import 'package:bloc_countdown_timer_app/ticker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:bloc_countdown_timer_app/timer_bloc.dart';

// https://pub.dev/packages/percent_indicator

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        // Creating a new TimerBloc instance,
        // Will be used in the rest of subtree widgets
        create: (context) => TimerBloc(ticker: const Ticker()),
        child: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late AnimatedDinosaur dinosaur;

  double _percent(BuildContext context, TimerState state) {
    if (state is TimerRunCompleteState) {
      dinosaur.flip();
    }
    return context.select(
        (TimerBloc bloc) => bloc.state.duration / bloc.state.maxDuration);
  }

  // final _animationController = AnimationController(duration: const Duration(seconds: 4), vsync: 5);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircularPercentIndicator(
                  radius: 80.0,
                  lineWidth: 10.0,
                  percent: _percent(
                      context, context.select((TimerBloc bloc) => bloc.state)),
                  //    header: const Text("Remaining Time"),
                  center: Text(
                    '${context.select((TimerBloc bloc) => bloc.state.duration)}',
                    style: const TextStyle(fontSize: 45),
                  ),
                ),
              ),

              dinosaur =
                  const AnimatedDinosaur(iconData: MdiIcons.googleDownasaur),

              const ActionButtons(),

              // show us the name of the state
              Text(
                '${context.select((TimerBloc bloc) => bloc.state)}',
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ActionButtons extends StatelessWidget {
  const ActionButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimerBloc, TimerState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            if (state is TimerInitialState) ...[
              FloatingActionButton(
                child: const Icon(Icons.play_arrow),

                // Changes from current state to TimerStarted state
                onPressed: () => context
                    .read<TimerBloc>()
                    .add(TimerStartedEvent(state.duration)),
              )
            ] else if (state is TimerRunInProgressState) ...[
              FloatingActionButton(
                  child: const Icon(Icons.pause),
                  // changes from currenty state -> TimerPaused state
                  onPressed: () =>
                      context.read<TimerBloc>().add(const TimerPausedEvent())),
              FloatingActionButton(
                  child: const Icon(Icons.refresh),
                  onPressed: () =>
                      context.read<TimerBloc>().add(TimerResetEvent())),
            ] else if (state is TimerRunPauseState) ...[
              FloatingActionButton(
                  child: const Icon(Icons.play_arrow),
                  // change from current state to TimerRunPause state
                  onPressed: () => context
                      .read<TimerBloc>()
                      .add(TimerResumedEvent(state.duration))),
              FloatingActionButton(
                child: const Icon(Icons.refresh),
                onPressed: () =>
                    context.read<TimerBloc>().add(TimerResetEvent()),
              )
            ] else if (state is TimerRunCompleteState) ...[
              // changing from current state to TimerReset state
              FloatingActionButton(
                child: const Icon(Icons.refresh),
                onPressed: () =>
                    context.read<TimerBloc>().add(TimerResetEvent()),
              )
            ],
          ],
        );
      },
    );
  }
}
