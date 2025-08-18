/*
==========================
FutureProvider  
==========================

What it does:
    Exposes the result of a Future to the widget tree.
    Automatically rebuilds the UI when the Future completes.

When to use:
    When you need async data (like API calls, database queries, or local storage)
    and want your UI to react when the result is ready.
*/

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// STEP 1: Create a Future function (simulating API or async work)
Future<String> fetchMessage() async {
  await Future.delayed(const Duration(seconds: 2)); // simulate network delay
  return "Hello from FutureProvider!";
}

void main() {
  runApp(
    // STEP 2: Wrap app with FutureProvider
    FutureProvider<String>(
      create: (_) => fetchMessage(),
      initialData: "Loading...", // shown until future completes
      child: const FutureProviderApp(),
    ),
  );
}

class FutureProviderApp extends StatelessWidget {
  const FutureProviderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'FutureProvider Example',
      home: FutureProviderScreen(),
    );
  }
}

class FutureProviderScreen extends StatelessWidget {
  const FutureProviderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // STEP 3: Access the provided data
    final message = context.watch<String>();

    return Scaffold(
      appBar: AppBar(title: const Text("FutureProvider Example")),
      body: Center(
        child: Text(message, style: const TextStyle(fontSize: 20)),
      ),
    );
  }
}

/*
==========================
Best Practices & Common Pitfalls
==========================

1. Always provide `initialData` to avoid null errors in the UI.
   Example: initialData: "Loading..."

2. Handle errors inside the Future itself with try/catch or return a fallback value.
   Otherwise, your app may crash if the future throws an error.

3. Do not call the future method directly in build().
   Always declare it outside (like fetchMessage()) to avoid restarting on every rebuild.

  class WrongExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // ❌ BAD: future restarts every rebuild
    return FutureProvider<String>(
      create: (_) => fetchMessage(), // runs again each build!
      initialData: "Loading...",
      child: Text(context.watch<String>()),
    );
  }
}

4. Use FutureProvider for one-time async data. 
   For continuous updates (like Firebase or sockets), use StreamProvider instead.
*/
