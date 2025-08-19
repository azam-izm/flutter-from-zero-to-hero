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
   1️⃣ Define a FutureProvider → Wrap async logic inside a Future.  
   2️⃣ Wrap app with ProviderScope → Enables Riverpod globally.  
   3️⃣ Use ConsumerWidget → Consume provider inside widgets.  
   4️⃣ Use ref.watch() → Access AsyncValue<T> returned by FutureProvider.  
   5️⃣ Handle states → Use `.when()` to handle `loading`, `error`, and `data`.  

🔹 Refresh vs Invalidate:
   - refresh = keep old, then update  
   - invalidate = clear old, show loading  

🔹 General Best Practice:
   Always declare async logic inside a provider, 
   never directly inside the build() method.  
--------------------------------------------
*/

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Step 1️⃣: Define a FutureProvider
final messageProvider = FutureProvider<String>((ref) async {
  // if the current second is even → return instantly (pretend cached value)
  if (DateTime.now().second % 2 == 0) {
    return "⚡ Cached value at \n${DateTime.now()}";
  } else {
  // If odd second → simulate API delay
  await Future.delayed(const Duration(seconds: 2));
  return "⏰ Fresh value at \n${DateTime.now()}";
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
    final asyncMessage = ref.watch(messageProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FutureProvider Example',
      home: Scaffold(
        appBar: AppBar(title: const Text('Riverpod Future Example')),
        body: Center(
          // Step 5️⃣: Handle all states
          child: asyncMessage.when(
            data: (msg) => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(msg, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                if (asyncMessage.isRefreshing) Column(
                    children: const [
                      SizedBox(height: 10),
                      CircularProgressIndicator(),
                    ],
                  ),
              ],
            ),
            loading: () => const CircularProgressIndicator(),
            error: (err, stack) => Text("Error: $err", style: const TextStyle(color: Colors.red)),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          heroTag: "refresh",
          label: const Text("Refresh"),
          onPressed: () {
            // 🔄 Smooth refresh: keeps old data, then updates when ready
            ref.refresh(messageProvider);

            // ❌ Uncomment this if you want to clear state immediately
            // ref.invalidate(messageProvider);
          },
        ),
      ),
    );
  }
}
