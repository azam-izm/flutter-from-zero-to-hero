/*
==========================
StreamProvider
==========================

What it does:
    Exposes data from a Stream to the widget tree.
    Automatically rebuilds only the widgets that depend on that data.

When to use:
    When you need real-time or continuous updates.
    Examples: Firebase Firestore snapshots, WebSockets, countdown timers, etc.
*/

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// STEP 1: Create a Stream function (simulating a timer or data source)
Stream<int> counterStream() async* {
  for (int i = 1; i <= 5; i++) {
    await Future.delayed(const Duration(seconds: 1));
    yield i; // emit new value
  }
}

void main() {
  runApp(
    // STEP 2: Wrap app with StreamProvider
    StreamProvider<int>(
      create: (_) => counterStream(),
      initialData: 0, // shown until stream emits first value
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({ super.key });

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'StreamProvider Example',
      home: StreamProviderScreen(),
    );
  }
}

class StreamProviderScreen extends StatelessWidget {
  const StreamProviderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("StreamProvider Example")),
      body: Center(
        // STEP 3: Wrap only the Text widget with Consumer
        child: Consumer<int>(
          builder: (context, counter, child) {
            return Text('Counter: $counter', style: const TextStyle(fontSize: 22),
            );
          },
        ),
      ),
    );
  }
}

/*
==========================
Best Practices & Common Pitfalls
==========================

1. Use Consumer to limit rebuilds to only the widget(s) that depend on stream data.
   Avoid calling context.watch<T>() high up in the widget tree.

2. Always provide initialData so UI has a safe starting value.

3. Keep Stream creation outside build() so it doesn't restart unnecessarily.

4. Use FutureProvider if you only need one async result; use StreamProvider for continuous updates.
*/
