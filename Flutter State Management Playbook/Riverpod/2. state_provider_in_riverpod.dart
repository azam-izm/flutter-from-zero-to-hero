/*
--------------------------------------------
       📌 Riverpod StateProvider in Flutter
--------------------------------------------

🔹 Purpose:
   The `StateProvider` in Riverpod manages **mutable state** that can be updated dynamically, 
   such as counters, toggles, or form inputs. It’s ideal for simple state that doesn’t require complex logic.

🔹 Steps Overview:
   1. Define a StateProvider → Holds and updates mutable state.
   2. Wrap the app with ProviderScope → Enables Riverpod globally.
   3. Use ConsumerWidget/Consumer → Rebuild UI efficiently when state changes.
   4. Update state with ref.read() → Modify state in event handlers (e.g., button presses).
   5. Optimize rebuilds → Use `Consumer` to limit UI updates to specific parts.

--------------------------------------------
*/

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Step 1️⃣: Define a StateProvider
// Holds an integer state, initialized to 0.
final counterProvider = StateProvider<int>((ref) => 0);

void main() {
  // Step 2️⃣: ProviderScope enables Riverpod for the entire app.
  runApp(const ProviderScope(child: MyApp()));
}

// Step 3️⃣: Use ConsumerWidget to access providers via `ref`.
class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // This build runs once (no direct ref.watch), ensuring efficiency.
    print('build');
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text('Riverpod StateProvider Example')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Step 5️⃣: Use Consumer to rebuild ONLY the Text widget.
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
                  // Step 4️⃣: Update state with ref.read in event handlers.
                  ElevatedButton(
                    onPressed: () => ref.read(counterProvider.notifier).state++,
                    child: const Text('+'),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () => ref.read(counterProvider.notifier).state--,
                    child: const Text('-'),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () {
                      final currentState = ref.read(counterProvider);
                      if (currentState != 0) {
                        ref.read(counterProvider.notifier).state =
                            currentState ~/ 2; // Integer division
                      }
                    },
                    child: const Text('/'),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () {
                      final currentState = ref.read(counterProvider);
                      ref.read(counterProvider.notifier).state =
                          currentState * 2; // Multiply by 2
                    },
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
1️⃣ `counterProvider` → Initializes to `0`.
2️⃣ `ProviderScope` → Enables Riverpod state management.
3️⃣ `MyApp` → Builds UI once (no direct `ref.watch`).
4️⃣ `Consumer` → Watches `counterProvider`, rebuilds only `Text`.
5️⃣ **Button (+)** → `ref.read` increments counter.
6️⃣ **Button (-)** → `ref.read` decrements counter.
7️⃣ **Button (/)** → Halves counter (if non-zero).
8️⃣ **Button (*)** → Doubles counter.
9️⃣ UI updates **only** the `Text` widget on state change.
--------------------------------------------

✅ **Key Takeaways:**
- Use `StateProvider` for **simple mutable state** (counters, switches).
- `Consumer` isolates rebuilds → **Optimize performance**.
- Always use `ref.read` in **event handlers** (not `context.read`).
- `ProviderScope` is **required** at the root.
*/
