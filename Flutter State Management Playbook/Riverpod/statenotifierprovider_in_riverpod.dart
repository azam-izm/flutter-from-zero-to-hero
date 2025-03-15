/*
--------------------------------------------
       📌 Riverpod StateNotifierProvider in Flutter
--------------------------------------------

🔹 **Purpose:**
   `StateNotifierProvider` is used to **manage complex mutable state** in Riverpod, 
   allowing business logic separation and explicit state updates.

🔹 **Steps Overview:**
   1. **Create a StateNotifier** → Extends `StateNotifier<T>` to manage state.
   2. **Define a StateNotifierProvider** → Exposes StateNotifier instance.
   3. **Wrap the app with `ProviderScope`** → Enables Riverpod globally.
   4. **Use `ConsumerWidget/Consumer`** → Efficiently listen to state changes.
   5. **Modify state via notifier methods** → Call functions to update state.

--------------------------------------------
*/

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Step 1️⃣: Create a StateNotifier
// `CounterNotifier` extends `StateNotifier<int>` and manages the counter logic.
class CounterNotifier extends StateNotifier<int> {
  CounterNotifier() : super(0); // Initial state is 0

  void increment() => state++;
  void decrement() => state--;
  void doubleValue() => state *= 2;
  void halveValue() {
    if (state != 0) state ~/= 2; // Integer division
  }
}

// Step 2️⃣: Define a StateNotifierProvider
// This provider exposes `CounterNotifier` to the app.
final counterProvider = StateNotifierProvider<CounterNotifier, int>((ref) {
  return CounterNotifier();
});

void main() {
  // Step 3️⃣: Wrap the app with `ProviderScope`
  runApp(const ProviderScope(child: MyApp()));
}

// Step 4️⃣: Use ConsumerWidget to consume the provider
class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print('build');
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar:
            AppBar(title: const Text('Riverpod StateNotifierProvider Example')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Step 5️⃣: Use Consumer to rebuild only the Text widget
              Consumer(
                builder: (context, ref, child) {
                  print('Consumer Text');
                  final counter = ref.watch(counterProvider);
                  return Text(
                    'Counter: $counter',
                    style: const TextStyle(fontSize: 24),
                  );
                },
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () =>
                        ref.read(counterProvider.notifier).increment(),
                    child: const Text('+'),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () =>
                        ref.read(counterProvider.notifier).decrement(),
                    child: const Text('-'),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () =>
                        ref.read(counterProvider.notifier).halveValue(),
                    child: const Text('/'),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () =>
                        ref.read(counterProvider.notifier).doubleValue(),
                    child: const Text('*'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/*
--------------------------------------------
          📌 Dry Run (Execution Flow)
--------------------------------------------
1️⃣ `CounterNotifier` → Manages counter logic with initial state `0`.
2️⃣ `StateNotifierProvider` → Provides `CounterNotifier` to widgets.
3️⃣ `MyApp` → Builds UI once (no direct `ref.watch`).
4️⃣ `Consumer` → Watches `counterProvider`, rebuilds only `Text`.
5️⃣ **Button (+)** → Calls `increment()` to increase counter.
6️⃣ **Button (-)** → Calls `decrement()` to decrease counter.
7️⃣ **Button (/)** → Calls `halveValue()` (divides by 2 if non-zero).
8️⃣ **Button (*)** → Calls `doubleValue()` (multiplies by 2).
9️⃣ UI updates **only** the `Text` widget when state changes.
--------------------------------------------

✅ **Key Takeaways:**
- `StateNotifierProvider` is best for **complex state logic**.
- `StateNotifier` **encapsulates logic** inside a dedicated class.
- `Consumer` optimizes **UI performance** by reducing rebuilds.
- Use `ref.read(counterProvider.notifier).method()` to update state.
- Always wrap the app with `ProviderScope`.
*/
