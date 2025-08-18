/*
--------------------------------------------
       📌 FutureProvider in Riverpod 
--------------------------------------------

🔹 Purpose:
   The `FutureProvider` is used to handle asynchronous data in Riverpod.  
   It automatically manages the state of a `Future` (loading, error, or data).  

   Common use cases:
   - Fetching data from an API or database.
   - Loading configuration files.
   - Simulating delayed operations (like loading user info).

🔹 Steps Overview:
   1️⃣ Define a FutureProvider → Wraps async logic inside a Future.  
   2️⃣ Wrap app with ProviderScope → Enables Riverpod globally.  
   3️⃣ Use ConsumerWidget → Consume provider inside widgets.  
   4️⃣ Use ref.watch() → Access AsyncValue<T> returned by FutureProvider.  
   5️⃣ Handle states → Use `.when()` to handle `loading`, `error`, and `data`.  

🔹 Best Practice:
   Always declare async logic inside a provider, 
   never directly inside the build() method.  
--------------------------------------------
*/

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Step 1️⃣: Define a FutureProvider
final messageProvider = FutureProvider<String>((ref) async {
  await Future.delayed(const Duration(seconds: 2));
  return "Hello from Future 👋";
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
    final asyncMessage = ref.watch(messageProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FutureProvider Example',
      home: Scaffold(
        appBar: AppBar(title: const Text('Riverpod Future Example')),
        body: Center(
          // Step 5️⃣: Handle all states
          child: asyncMessage.when(
            data: (msg) => Text(
              msg,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            loading: () => const CircularProgressIndicator(),
            error: (err, stack) => Text(
              "Error: $err",
              style: const TextStyle(color: Colors.red),
            ),
          ),
        ),
      ),
    );
  }
}
