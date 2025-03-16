import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:async';

/*
--------------------------------------------
       📌 Riverpod StreamProvider in Flutter
--------------------------------------------

🔹 Purpose: 
   The `StreamProvider` in Riverpod is used to manage **real-time data streams**, such as WebSockets, 
   Firebase Firestore streams, or periodic data updates.

🔹 Steps Overview:
   1. Define a `StreamProvider` using `async*` → Emits values over time.
   2. Wrap the app with `ProviderScope` → Enables Riverpod globally.
   3. Use `ref.watch()` → Watches the stream for updates.
   4. Handle different states with `when()` → `data`, `loading`, `error`.
   5. Display streamed data dynamically in the UI.
--------------------------------------------
*/

// Step 1️⃣: Define a `StreamProvider` using `async*`.
final counterStreamProvider = StreamProvider<int>((ref) async* {
  int count = 0;
  while (true) {
    await Future.delayed(const Duration(seconds: 1)); // Simulate delay
    yield count++; // Emit new values
  }
});

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

// Step 2️⃣: Create a StatelessWidget to avoid unnecessary rebuilds.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    print('build MyApp'); // Printed only once
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('StreamProvider Example',
              style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.black,
        ),
        body:
            const CounterWidget(), // Step 3️⃣: Extract UI logic to a separate widget
      ),
    );
  }
}

// Step 4️⃣: Use `ConsumerWidget` to optimize UI updates.
class CounterWidget extends ConsumerWidget {
  const CounterWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print('build CounterWidget'); // Only this widget will rebuild
    final counterStream = ref.watch(counterStreamProvider);

    return Center(
      child: counterStream.when(
        data: (count) => Text(
          'Counter: $count',
          style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        loading: () => const CircularProgressIndicator(),
        error: (error, stack) => Text('Error: $error'),
      ),
    );
  }
}

/*
--------------------------------------------
          📌 Dry Run (Execution Flow)
--------------------------------------------
1️⃣ `counterStreamProvider` → Starts emitting a value **every second**.
2️⃣ `ProviderScope` → Enables Riverpod's state management.
3️⃣ `MyApp` (StatelessWidget) → Prevents unnecessary rebuilds.
4️⃣ `CounterWidget` (ConsumerWidget) → Watches `counterStreamProvider`.
5️⃣ `counterStream.when()` → Handles **loading, data, and error states**.
6️⃣ **Loading state** → Shows `CircularProgressIndicator()` while waiting for the first value.
7️⃣ **Data state** → Updates **counter** value every second dynamically.
8️⃣ **Error state** → Displays error message if stream fails.
9️⃣ **Only `CounterWidget` rebuilds** → Prevents app-wide unnecessary updates.
--------------------------------------------

✅ **Key Takeaways:**
- `StreamProvider` is ideal for **real-time data** (e.g., Firebase, WebSockets, sensor data).
- **Use `async*` instead of `Stream.periodic`** for better control and error handling.
- `ConsumerWidget` ensures **only relevant UI updates** for performance.
- `ProviderScope` is **mandatory** to enable Riverpod globally.
*/
