// import 'dart:html';

import 'dart:math';

import 'package:bloc_app/counter_bloc.dart';
import 'package:bloc_app/counter_event.dart';
import 'package:bloc_app/counter_state.dart';
import 'package:bloc_app/shared/shared.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'injection_container.dart' as di;
import 'injection_container.dart';

void main() async => {await di.init(), runApp(const MyApp())};

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Color getRandomColor() {
    List colors = [
      Colors.red,
      Colors.green,
      Colors.yellow,
      Colors.blue,
      Colors.amber,
      Colors.purple,
      Colors.cyan,
      Colors.limeAccent
    ];
    Random random = Random();
    int randomIndex = random.nextInt(colors.length);
    Color randomColor = colors[randomIndex];

    return randomColor;
  }

  bool displayTens(int currentNumber) {
    bool display = false;

    if (currentNumber >= 10) {
      display = true;
    }

    return display;
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        child: BlocProvider(
          create: (context) => sl<CounterBloc>(),
          child: BlocBuilder<CounterBloc, CounterState>(
            builder: (context, state) {
              if (state is CounterIncrementState ||
                  state is CounterDecrementState) {
                return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'You have pushed the button this many times:',
                      ),
                      Text(
                        '${state is CounterIncrementState ? state.tensAndOnes.ones : state is CounterDecrementState ? state.tensAndOnes.ones : 0}',
                        //  style: Theme.of(context).textTheme.displayMedium,
                        style: TextStyle(
                            color: Shared.getRandomColor(), fontSize: 22),
                      ),
                      Visibility(
                        visible: state is CounterIncrementState
                            ? displayTens(state.tensAndOnes.tens)
                            : state is CounterDecrementState
                                ? displayTens(state.tensAndOnes.tens)
                                : false,
                        maintainSize: true,
                        maintainState: true,
                        maintainAnimation: true,
                        child: Text(
                          '${state is CounterIncrementState ? state.tensAndOnes.tens : state is CounterDecrementState ? state.tensAndOnes.tens : 0}',
                          //  style: Theme.of(context).textTheme.displayMedium,
                          style: const TextStyle(
                              color: Colors.black, fontSize: 22),
                        ),
                      )
                    ]);
              } //if

              else {
                return Container();
              }
            },
          ),
        ),
      ),

      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () => sl<CounterBloc>().add(IncrementEvent()),
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
          const SizedBox(width: 10),
          FloatingActionButton(
            onPressed: () => sl<CounterBloc>().add(DecrementEvent()),
            tooltip: 'Decrement',
            child: const Icon(Icons.remove),
          ),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
