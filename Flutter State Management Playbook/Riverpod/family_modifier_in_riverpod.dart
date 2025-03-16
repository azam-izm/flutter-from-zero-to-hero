import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/*
--------------------------------------------
       📌 Riverpod `family` Modifier
--------------------------------------------
🔹 Purpose:
   - `family` is used when a provider needs **dynamic parameters**.
   - It allows us to generate **different outputs** based on input values.
--------------------------------------------
*/

// Step 1️⃣: Define a `Provider.family` that takes a `name` parameter.
final nameProvider = Provider.family<String, String>((ref, name) {
  return "Hi $name"; // Returns a personalized greeting
});

void main() {
  // Step 2️⃣: Wrap the app with `ProviderScope` to enable Riverpod.
  runApp(const ProviderScope(
    child: MyApp(),
  ));
}

// Step 3️⃣: Use `ConsumerWidget` to watch the provider and pass a parameter.
class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Step 4️⃣: Pass a dynamic parameter to `nameProvider`
    final name = ref.watch(nameProvider('Muhammad Azam'));

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Provider.family Demo',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Provider.family Demo'),
        ),
        body: Center(
          child: Text(
            name, // Display the computed string
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
1️⃣ `nameProvider` is called with **'Muhammad Azam'** as a parameter.
2️⃣ The provider computes → `"Hi Muhammad Azam"`.
3️⃣ `ProviderScope` enables Riverpod to manage state.
4️⃣ `MyApp` watches `nameProvider('Muhammad Azam')`, so it gets the greeting.
5️⃣ The computed **string** is displayed in the `Text` widget.
6️⃣ If a different name is passed, the output will change accordingly.
--------------------------------------------

✅ **Key Takeaways:**
- `Provider.family` allows **dynamic parameters** in providers.
- `ref.watch(nameProvider(parameter))` makes providers **parameterized**.
- `ProviderScope` is **mandatory** to use Riverpod.
- Ideal for **API calls with IDs**, **filters**, or **dynamic queries**.
*/
