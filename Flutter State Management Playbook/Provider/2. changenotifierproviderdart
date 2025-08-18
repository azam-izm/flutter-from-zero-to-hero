/*
Using ChangeNotifierProvider in Provider Package

1. Define a class that extends ChangeNotifier.
   - Holds state in private variables.
   - Exposes getters.
   - Calls notifyListeners() when state changes.

2. Wrap your app with ChangeNotifierProvider.
   - Makes the state available across the widget tree.
   - Use `create` or `.value` constructor.

3. Trigger changes with context.read() or Provider.of(..., listen: false).
   - These do not rebuild the widget that calls them.

4. Listen to changes with Consumer, context.watch(), or Provider.of().
   - These rebuild when notifyListeners() is called.
*/
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// STEP 1: Declare a class that extends ChangeNotifier
class Counter with ChangeNotifier {
  int _count = 0;
  int get count => _count;

  void increment() {
    _count++;
    notifyListeners();
  }
}

void main() {
  runApp(
    // STEP 2: Wrap application with ChangeNotifierProvider
    ChangeNotifierProvider(
      create: (context) => Counter(),
      child: const CounterApp(),
    ),
  );

  // --- Alternative way using .value ---
  // final counter = Counter();
  // runApp(
  //   ChangeNotifierProvider.value(
  //     value: counter,
  //     child: const CounterApp(),
  //   ),
  // );
}

class CounterApp extends StatelessWidget {
  const CounterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'ChangeNotifierProvider in Provider',
      home: CounterScreen(),
    );
  }
}

class CounterScreen extends StatelessWidget {
  const CounterScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // STEP 3: Trigger a change using read()
            context.read<Counter>().increment();

            // --- Alternative ways ---
            // Provider.of<Counter>(context, listen: false).increment();
          },
          child: Consumer<Counter>(
            // STEP 4: Wrap receiving data widget with Consumer
            builder: (context, counter, child) {
              // print('Consumer build'); // to demo rebuilds
              return Text('${counter.count}');

              // --- Alternative ways ---
              // return Text('${context.watch<Counter>().count}');
              // return Text('${Provider.of<Counter>(context).count}');
            },
          ),
        ),
      ),
    );
  }
}
