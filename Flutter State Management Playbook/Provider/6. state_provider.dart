/*
==========================
StateProvider (using ValueNotifier with Provider package)
==========================

What it does:
    Provides a small piece of mutable state (like int, bool, String).
    Whenever the value changes, only the widgets listening to it rebuild.

When to use:
    When you have simple state updates and don’t want to create a full ChangeNotifier class.
    Example: counters, toggles, selected indexes, text values, etc.
*/

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    // STEP 1: Provide a ValueNotifier<int> as state container
    ChangeNotifierProvider<ValueNotifier<int>>(
      create: (_) => ValueNotifier<int>(0), // initial value = 0
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'StateProvider Example',
      home: CounterScreen(),
    );
  }
}

class CounterScreen extends StatelessWidget {
  const CounterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // STEP 2: Access the ValueNotifier<int>
    final counterNotifier = context.read<ValueNotifier<int>>();

    return Scaffold(
      appBar: AppBar(title: const Text("StateProvider Example")),
      body: Center(
        // STEP 3: Rebuild only the Text widget using ValueListenableBuilder
        child: ValueListenableBuilder<int>(
          valueListenable: counterNotifier,
          builder: (context, value, child) {
            return Text(
              'Counter: $value',
              style: const TextStyle(fontSize: 24),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => counterNotifier.value++, // update state
        child: const Icon(Icons.add),
      ),
    );
  }
}

/*
==========================
Best Practices & Common Pitfalls
==========================

1. Use ValueNotifier for simple values (int, bool, String).
   For complex models, prefer ChangeNotifier or other state management.

2. Always wrap widgets that display the value with ValueListenableBuilder
   so only that part of the UI rebuilds.

3. Keep state small and focused. Don’t overload a ValueNotifier with too much logic.
*/
