/*
Lecture: Mastering State Management with Provider in Flutter

Introduction:
The Provider package is a powerful state management solution for Flutter applications. It promotes a clean separation 
between UI and business logic, making your code easier to manage, test, and scale. Provider simplifies sharing state 
across the widget tree without the need for complex patterns or excessive boilerplate code.

Installation:
To add Provider to your project, run:
flutter pub add provider
Alternatively, add the following to your pubspec.yaml:
dependencies:
provider: ^6.1.2 // Ensure you have the latest version.

Overview of the Code:

State Definition with ChangeNotifier:

The Counter class uses ChangeNotifier to notify listeners whenever its state changes.

A private variable _count stores the state, and a getter count exposes it.

The increment method updates the counter and calls notifyListeners() to trigger UI updates.

Setting Up the Provider:

In main(), ChangeNotifierProvider wraps the entire app, making the Counter instance available throughout the widget tree.

This setup ensures a centralized and reactive approach to state management.

Consuming the State:

The ElevatedButton in MyApp uses context.read<Counter>().increment() to update the state without unnecessary widget rebuilds.

The Consumer widget listens to state changes and rebuilds only the relevant part of the UI when the state updates.

Alternative methods like Provider.of are also demonstrated for flexibility.

Debugging and Performance:

Print statements in build methods help track widget rebuilds, aiding in performance optimization.

Conclusion:
By integrating Provider, developers can efficiently manage state, promote clean code practices, and build responsive, 
scalable apps. Provider is a must-have tool for any Flutter developer looking to streamline state management.

Happy Coding!
*/

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//STEP 1: Declare a class with ChangeNotifier
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
    //STEP 2: Wrap application with ChangeNotifierProvider
    ChangeNotifierProvider(
      create: (context) => Counter(),
      child: const MyApp(),
    ),
  );
}

// void main() {
//   final counter = Counter();
//   runApp(
//     ChangeNotifierProvider.value(
//       value: counter,
//       child: const MyApp(),
//     ),
//   );
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    print('build');
    return MaterialApp(
      title: 'Counter app using Provider',
      home: Scaffold(
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              //STEP 3: Use provider.of with listen: false to trigger the change OR context.read<ClassName>.functionName;
              context.read<Counter>().increment();
              // Provider.of<Counter>(context, listen: false).increment();
            },
            child: Consumer<Counter>(
              //STEP 4: Wrap receiving data widget with Consumer widget
              builder: (ctx, _, __) {
                print('Consumer');
                return Text('${ctx.watch<Counter>().count}');
                // return Text('${Provider.of<Counter>(ctx).count}');
              },
            ),

            // child: Consumer<Counter>(
            //   //STEP 4: Wrap receiving data widget with Consumer widget
            //   builder: (context, counter, child) {
            //     return Text('${counter.count}');
            //   },
            // ),
          ),
        ),
      ),
    );
  }
}
