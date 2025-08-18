/*
--------------------------------------------
       📌 Provider Overrides (Scoped values)
--------------------------------------------

🔹 Purpose:
   - Sometimes you want to use different values for the same provider 
     in different parts of your app.
   - Example: Inject a mock API in tests, or show different configs
     for child widgets without affecting the global app.

   ✅ In Riverpod 2.x, `ScopedProvider` is replaced by **overrides**.

🔹 Steps Overview:
   1️⃣ Define a Provider → Exposes a value (e.g., a String message).  
   2️⃣ Wrap root app with ProviderScope.  
   3️⃣ Wrap a child widget with another ProviderScope → Override the provider.  
   4️⃣ Inside child widgets, `ref.watch()` will give the overridden value.  
   5️⃣ Nested overrides take precedence over outer/global providers.

--------------------------------------------
*/

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final greetingProvider = Provider<String>((ref) => "Hello from Global Provider 🌍");

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final greeting = ref.watch(greetingProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Provider Overrides Example',
      home: Scaffold(
        appBar: AppBar(title: const Text('Riverpod Overrides')),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(greeting, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 20),

            // Step 3️⃣: Nested overrides take precedence
            ProviderScope(
              overrides: [
                greetingProvider.overrideWithValue("Hello from Scoped Override 🎯"),
              ],
              child: const OverriddenWidget()
            ),
          ],
        ),
      ),
    );
  }
}

// Widget that uses overridden provider
class OverriddenWidget extends ConsumerWidget {
  const OverriddenWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final scopedGreeting = ref.watch(greetingProvider);
    return Text(scopedGreeting, style: const TextStyle(fontSize: 22, color: Colors.blue));
  }
}

/*
--------------------------------------------
          📌 Dry Run (Execution Flow)
--------------------------------------------
1️⃣ greetingProvider → Globally provides "Hello from Global Provider 🌍".
2️⃣ MyApp → Reads global value and displays it.
3️⃣ ProviderScope (override) → Replaces greetingProvider with 
   "Hello from Scoped Override 🎯" for its subtree.
4️⃣ OverriddenWidget → Reads overridden value instead of global.
5️⃣ Nested overrides (if any) take precedence over outer/global providers.

✅ Key Takeaways:
- ScopedProvider was removed; use overrides instead.
- `ProviderScope(overrides: [...])` lets you inject custom values locally.
- Great for testing, theming, mock APIs, and feature toggles.
- `ref.watch()` will always return the **nearest scoped value**.
- UI distinction helps visually understand scoped overrides.
*/
