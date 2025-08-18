/*
--------------------------------------------
       📌 Riverpod Provider in Flutter
--------------------------------------------

🔹 **Purpose:**
   The `Provider` in Riverpod is used to **expose** immutable (read-only) values such as strings, integers, or configurations throughout the app.

🔹 **Steps Overview:**
   1️⃣ **Define a Provider** → Creates and manages immutable data.
   2️⃣ **Wrap the app with `ProviderScope`** → Enables Riverpod globally.
   3️⃣ **Use `ConsumerWidget`** → Allows widgets to consume provider values.
   4️⃣ **Access provider using `ref.watch()`** → Reads the provided value inside the widget.
   5️⃣ **Display the value in UI** → Uses a `Text` widget to show the value.

--------------------------------------------
*/

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Step 1️⃣: Define a Provider
// This provider exposes a simple string value "Provider in Riverpod".
final greetingProvider = Provider<String>((ref) => 'Provider in Riverpod');

void main() {
  // Step 2️⃣: Wrap the app with `ProviderScope`
  // This is required for Riverpod to work and should be at the root level.
  runApp(const ProviderScope(child: MyApp()));
}

// Step 3️⃣: Use `ConsumerWidget` to consume the provider
class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) { // `ConsumerWidget` automatically gives access to `ref` for watching providers.
    // Step 4️⃣: Access the provider using `ref.watch()`
    // `ref.watch(greetingProvider)` listens to changes in the provider
    final greeting = ref.watch(greetingProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Provider in Riverpod',
      home: Scaffold(
        appBar: AppBar(title: const Text('Riverpod Provider Example')),
        body: Center(
          child: Text(
            greeting, // Step 5️⃣: Display the provider's value
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
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
1️⃣ greetingProvider → Holds the string 'Provider in Riverpod'.
2️⃣ ProviderScope → Enables Riverpod state management.
3️⃣ MyApp` (ConsumerWidget) → Reads `greetingProvider` using `ref.watch()`.
4️⃣ ref.watch(greetingProvider) → Retrieves the value and rebuilds UI if it changes.
5️⃣ Text(greeting) → Displays 'Provider in Riverpod' in the center of the screen.
--------------------------------------------

✅ **Key Takeaways:**
- `Provider` is used for **immutable (read-only) values**.
- `ConsumerWidget` is a simple way to use providers.
- `ref.watch()` **reactively listens** for changes.
- `ProviderScope` is mandatory to enable Riverpod globally.
*/
