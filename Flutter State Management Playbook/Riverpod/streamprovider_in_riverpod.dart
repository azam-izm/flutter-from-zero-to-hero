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
   1. Define a `StreamProvider` → Emits values over time.
   2. Wrap the app with `ProviderScope` → Enables Riverpod globally.
   3. Use `ref.watch()` → Watches the stream for updates.
   4. Handle different states with `when()` → `data`, `loading`, `error`.
   5. Display streamed data dynamically in the UI.
--------------------------------------------
*/

// Step 1️⃣: Define a `StreamProvider` that emits a value every second.
final counterStreamProvider = StreamProvider<int>((ref) {
  return Stream<int>.periodic(const Duration(seconds: 1), (count) => count + 1);
});

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    print('build MyApp'); // Will be printed only once
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('StreamProvider Example',
              style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.black,
        ),
        body:
            const CounterWidget(), // Step 2️⃣: Extract UI logic to a separate widget
      ),
    );
  }
}

// Step 3️⃣: Use ConsumerWidget for optimized updates.
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
3️⃣ `MyApp` (ConsumerWidget) → Watches `counterStreamProvider`.
4️⃣ `counterStream.when()` → Handles **loading, data, and error states**.
5️⃣ **Loading state** → Shows `CircularProgressIndicator()` while waiting for the first value.
6️⃣ **Data state** → Updates **counter** value every second dynamically.
7️⃣ **Error state** → Displays error message if stream fails.
8️⃣ **UI updates automatically** every second without manual intervention.
--------------------------------------------

✅ **Key Takeaways:**
- `StreamProvider` is ideal for **real-time data** (e.g., Firebase, WebSockets).
- `ref.watch()` listens for **new values** and updates the UI dynamically.
- `when()` makes handling **loading, success, and error states** easy.
- `ProviderScope` is **mandatory** for Riverpod to work.
*/
