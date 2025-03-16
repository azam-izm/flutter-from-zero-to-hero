import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:convert';

/*
--------------------------------------------
       📌 Riverpod FutureProvider in Flutter
--------------------------------------------

🔹 Purpose:
   The `FutureProvider` in Riverpod is used to handle **asynchronous operations**, such as API calls, 
   database queries, or file reading.

🔹 Steps Overview:
   1. Define a `FutureProvider` → Fetches data asynchronously.
   2. Wrap the app with `ProviderScope` → Enables Riverpod globally.
   3. Use `ref.watch()` → Watches the provider for state changes.
   4. Handle different states with `when()` → `data`, `loading`, `error`.
   5. Display fetched data in a `ListView` → Show results efficiently.
--------------------------------------------
*/

// Step 1️⃣: Define a `FutureProvider` to fetch cat facts from API.
final catFactProvider = FutureProvider<CatFactResponse>((ref) async {
  final url = Uri.parse('https://catfact.ninja/facts');

  try {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      return CatFactResponse.fromJson(jsonResponse); // Parse JSON response
    } else {
      throw Exception('Failed to load cat facts: ${response.statusCode}');
    }
  } catch (error) {
    throw Exception('Failed to load cat facts: $error');
  }
});

void main() {
  // Step 2️⃣: Wrap the app with `ProviderScope` to enable Riverpod.
  runApp(const ProviderScope(child: MyApp()));
}

// Step 3️⃣: Use `ConsumerWidget` to watch `FutureProvider`.
class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Step 4️⃣: Watch the `catFactProvider` to get API data.
    final catFact = ref.watch(catFactProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
              title: const Text('Cat Facts API',
                  style: TextStyle(color: Colors.white)),
              backgroundColor: Colors.black),

          // Step 5️⃣: Use `when()` to handle different states
          body: catFact.when(
            data: (data) {
              if (data.data == null || data.data!.isEmpty) {
                return const Center(child: Text("No cat facts available"));
              }

              return ListView.builder(
                padding: const EdgeInsets.all(8.0),
                itemCount: data.data?.length ?? 0,
                itemBuilder: (context, index) {
                  CatFact fact = data.data![index];

                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 4,
                    margin:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(15),
                      title: Text(
                        fact.fact ??
                            'No fact available', // Ensure no null values
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  );
                },
              );
            },
            loading: () => const Center(
                child: CircularProgressIndicator()), // Show loading state
            error: (error, stack) =>
                Center(child: Text('Error: $error')), // Handle error state
          )),
    );
  }
}

/*
--------------------------------------------
        📌 JSON Model Parsing
--------------------------------------------
- The API response contains a list of cat facts.
- `CatFactResponse` class handles the overall structure.
- `CatFact` class represents individual cat facts.
--------------------------------------------
*/

// Define a model class to parse API response.
class CatFactResponse {
  List<CatFact>? data; // List of cat facts

  CatFactResponse({this.data});

  // Convert JSON response into Dart object.
  CatFactResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <CatFact>[];
      json['data'].forEach((v) {
        data!.add(CatFact.fromJson(v)); // Parse each fact
      });
    }
  }
}

// Define a class for individual cat facts.
class CatFact {
  String? fact;

  CatFact({this.fact});

  // Convert JSON object into Dart object.
  CatFact.fromJson(Map<String, dynamic> json) {
    fact = json['fact'];
  }
}

/*
--------------------------------------------
          📌 Dry Run (Execution Flow)
--------------------------------------------
1️⃣ `catFactProvider` → Fetches data from API asynchronously.
2️⃣ `ProviderScope` → Enables Riverpod's state management.
3️⃣ `MyApp` (ConsumerWidget) → Watches `catFactProvider`.
4️⃣ `catFact.when()` → Handles **loading**, **data**, and **error** states.
5️⃣ **Loading state** → Shows `CircularProgressIndicator()`.
6️⃣ **Data state** → Parses API response into `CatFactResponse`.
7️⃣ **Error state** → Displays error message if request fails.
8️⃣ `ListView.builder` → Displays fetched cat facts in a list.
--------------------------------------------

✅ **Key Takeaways:**
- `FutureProvider` is used for **asynchronous operations** (API calls, databases).
- `ref.watch()` listens for changes and rebuilds UI accordingly.
- `when()` simplifies handling **loading, success, and error states**.
- `ProviderScope` is **mandatory** to enable Riverpod.
- Using a **model class** ensures structured JSON parsing.
*/

