import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/*
==========================
1. Introduction to autoDispose
==========================

`autoDispose` is a modifier in Riverpod that automatically disposes of a provider 
when it is no longer in use. This prevents memory leaks and improves performance.

📌 Benefits:
✅ Frees up memory by removing unused providers.
✅ Prevents unnecessary rebuilds when navigating between screens.
✅ Ensures cleanup of resources like network requests or database connections.

==========================
2. Using autoDispose with Different Providers
==========================

By default, Riverpod retains the state of a provider even if it's not used anymore.
However, `autoDispose` ensures that once there are no listeners, the state is cleared.

Example Usage:
- `StateProvider.autoDispose` → Simple state management that resets on screen exit.
- `FutureProvider.autoDispose` → Auto-disposes async operations (e.g., API calls).
- `StreamProvider.autoDispose` → Disposes stream listeners when leaving a screen.
*/

// 2.1 Counter that resets when leaving the screen
final counterProvider = StateProvider.autoDispose<int>((ref) => 0);

// 2.2 Retained counter (persists even after leaving the screen)
final retainedCounterProvider = StateProvider.autoDispose<int>((ref) {
  ref.keepAlive(); // Keeps state alive even after disposal
  return 0;
});

// 2.3 FutureProvider (Data Fetching that resets after disposal)
final dataProvider = FutureProvider.autoDispose<String>((ref) async {
  await Future.delayed(const Duration(seconds: 2));
  return "Fetched Data";
});

// 2.4 StreamProvider (Streaming data that resets after disposal)
final streamProvider = StreamProvider.autoDispose<int>((ref) async* {
  for (int i = 1; i <= 5; i++) {
    await Future.delayed(const Duration(seconds: 1));
    yield i;
  }
});

/*
==========================
3. Full App to Demonstrate autoDispose
==========================

This app includes:
✅ `autoDispose` Counter (resets when screen is left)
✅ Retained Counter (`keepAlive` keeps state even after disposal)
✅ `autoDispose` FutureProvider (fetches data and resets)
✅ `autoDispose` StreamProvider (resets real-time updates)
✅ Navigation between screens to test disposal behavior
*/

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Riverpod autoDispose Demo',
      theme: ThemeData.dark(),
      home: const HomeScreen(),
    );
  }
}

// ==========================
// Home Screen (Main UI)
// ==========================
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counter = ref.watch(counterProvider);
    final retainedCounter = ref.watch(retainedCounterProvider);
    final asyncData = ref.watch(dataProvider);
    final streamData = ref.watch(streamProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Riverpod autoDispose Demo")),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Counter with autoDispose
          Card(
            child: ListTile(
              title: Text("Counter (autoDispose): $counter"),
              subtitle: const Text("Resets when leaving the screen."),
              trailing: IconButton(
                icon: const Icon(Icons.add),
                onPressed: () => ref.read(counterProvider.notifier).state++,
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Retained Counter (keepAlive)
          Card(
            child: ListTile(
              title: Text("Retained Counter (keepAlive): $retainedCounter"),
              subtitle: const Text("State remains even after leaving screen."),
              trailing: IconButton(
                icon: const Icon(Icons.add),
                onPressed: () =>
                    ref.read(retainedCounterProvider.notifier).state++,
              ),
            ),
          ),

          const SizedBox(height: 20),

          // FutureProvider (Fetch data)
          Card(
            child: ListTile(
              title: const Text("Fetching Data (autoDispose)"),
              subtitle: asyncData.when(
                data: (value) => Text(value),
                loading: () => const CircularProgressIndicator(),
                error: (err, stack) => Text("Error: $err"),
              ),
            ),
          ),

          const SizedBox(height: 20),

          // StreamProvider (Real-time updates)
          Card(
            child: ListTile(
              title: const Text("Stream Data (autoDispose)"),
              subtitle: streamData.when(
                data: (value) => Text("Value: $value"),
                loading: () => const CircularProgressIndicator(),
                error: (err, stack) => Text("Error: $err"),
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Navigate to Second Screen (Forces Disposal)
          ElevatedButton(
            onPressed: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const SecondScreen()),
            ),
            child: const Text("Go to Second Screen (Forces Dispose)"),
          ),
        ],
      ),
    );
  }
}

// ==========================
// Second Screen (Navigating Back to Home)
// ==========================
class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Second Screen")),
      body: Center(
        child: ElevatedButton(
          onPressed: () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const HomeScreen()),
          ),
          child: const Text("Go Back to Home (Forces Dispose)"),
        ),
      ),
    );
  }
}

/*
==========================
4. Understanding Disposal Behavior
==========================

❌ `counterProvider` (autoDispose) → Resets when leaving the screen.
✅ `retainedCounterProvider` (keepAlive) → Retains state after navigation.
❌ `dataProvider` (autoDispose) → Fetches again when returning to the screen.
❌ `streamProvider` (autoDispose) → Resets stream updates after leaving the screen.

How to test?
1️⃣ Increase both counters.
2️⃣ Navigate to the second screen.
3️⃣ Return to the home screen.
4️⃣ `counterProvider` resets to 0 (disposed).
5️⃣ `retainedCounterProvider` keeps its value (not disposed).
6️⃣ Future and Stream re-run their logic (as they were disposed).

==========================
5. Best Practices for autoDispose
==========================

✅ Use `autoDispose` for temporary states like UI interactions or network calls.
✅ Use `keepAlive()` only when necessary to avoid memory leaks.
✅ `autoDispose` is ideal for widgets that appear and disappear frequently.
✅ Avoid using `autoDispose` for global app-wide states.

🎯 By properly using `autoDispose`, you can optimize memory usage while ensuring 
efficient state management in your Flutter app.
*/
