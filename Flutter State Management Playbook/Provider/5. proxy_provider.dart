/*
==========================
ProxyProvider
==========================

What it does:
    ProxyProvider lets one provider depend on another.
    Whenever the original provider updates, the ProxyProvider also updates.

When to use:
    When you need to transform or extend the data from an existing provider.
    Example: double a number, inject an auth token into an API service, etc.
*/

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        // STEP 1: Original provider
        Provider<int>(create: (_) => 5), // Provides a number "5" to the widget tree.
/*
        STEP 2: ProxyProvider
        The first type <int> tells ProxyProvider which provider it depends on.
        The second type <int> tells what type ProxyProvider itself provides.

        The types don’t have to be the same. For example, the first could be int 
        and the second String if you want to transform the data.
        
        This ProxyProvider automatically listens to the original provider (originalNumber)
        and uses the "update" function to transform its value.
        Here, it multiplies the original number by 2, so 5 becomes 10.
*/
        ProxyProvider<int, int>(
/*
          originalNumber comes from the first provider (Provider<int>)
          previousValue holds the previous value of ProxyProvider (not used here)
          ProxyProvider automatically "listens" to the original provider
          whenever the original value changes, update() runs again.
*/
          update: (context, originalNumber, previousValue) => originalNumber * 2,
          // previousValue holds the old doubled number
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    // STEP 3: Read the value provided by ProxyProvider
    int doubled = context.watch<int>(); // This gives us the transformed value, i.e., 10

    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Doubled number is $doubled', style: const TextStyle(fontSize: 20)),
        ),
      ),
    );
  }
}
