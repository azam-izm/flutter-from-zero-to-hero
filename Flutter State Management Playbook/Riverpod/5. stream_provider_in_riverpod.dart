/*
--------------------------------------------
       📌 StreamProvider in Riverpod 
--------------------------------------------

🔹 Purpose:
   The `StreamProvider` is used when you want to listen to a stream of 
   data that keeps changing over time.  
   It automatically manages stream states: `loading`, `error`, and `data`.

   Common use cases:
   - Realtime data from Firebase or databases.
   - Periodic timers or counters.
   - Event listeners (e.g., sockets, sensors).

🔹 Steps Overview:
   1️⃣ Define a StreamProvider → Wraps async logic inside a Stream.  
   2️⃣ Wrap app with ProviderScope → Enables Riverpod globally.  
   3️⃣ Use ConsumerWidget → Consume provider inside widgets.  
   4️⃣ Use ref.watch() → Access AsyncValue<T> returned by StreamProvider.  
   5️⃣ Handle states → Use `.when()` to handle `loading`, `error`, and `data`.  

🔹 Best Practice:
   Keep stream logic inside a provider, never directly inside the build() method.  
--------------------------------------------
*/

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Step 1️⃣: Define a StreamProvider
// Example: A counter that emits a new value every second.
final counterStreamProvider = StreamProvider<int>((ref) async* {
  int counter = 0;
  while (true) {
    await Future.delayed(const Duration(seconds: 1));
    yield counter++; // Emit new value
  }
});

void main() {
  // Step 2️⃣: Wrap app with ProviderScope
  runApp(const ProviderScope(child: MyApp()));
}

// Step 3️⃣: Use ConsumerWidget
class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Step 4️⃣: Watch the provider
    final asyncCounter = ref.watch(counterStreamProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'StreamProvider Example',
      home: Scaffold(
        appBar: AppBar(title: const Text('Riverpod Stream Example')),
        body: Center(
          // Step 5️⃣: Handle states (data, loading, error)
          child: asyncCounter.when(
            data: (value) => Text("Counter: $value", style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            loading: () => const CircularProgressIndicator(),
            error: (error, stack) => Text('Error: $error', style: const TextStyle(color: Colors.red)),
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
1️⃣ counterStreamProvider → Emits incrementing numbers every second.  
2️⃣ ProviderScope → Enables Riverpod globally.  
3️⃣ MyApp (ConsumerWidget) → Watches counterStreamProvider.  
4️⃣ ref.watch(counterStreamProvider) → Returns AsyncValue<int>.  
5️⃣ asyncCounter.when(...) → Displays:
     - Loading → CircularProgressIndicator.
     - Data → Shows incrementing counter.
     - Error → Shows error message.  

✅ Key Takeaways:
- Use StreamProvider for realtime/continuous data.  
- It manages subscription lifecycle automatically.  
- AsyncValue<T>.when makes UI reactive and safe.  
--------------------------------------------
*/
