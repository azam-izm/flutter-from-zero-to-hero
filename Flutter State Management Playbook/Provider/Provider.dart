/*
==========================
Provider
==========================
What it does:
     Provider is the simplest provider.
     It exposes a read-only value to the widget tree.
     Best for constants, configurations, or objects that do not change.

When to use:
     When your object doesn’t need to be updated or listened to.
    For example, exposing a service class.
*/

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    Provider<String>(
      create: (_) => "Hello Provider!",
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final message = Provider.of<String>(context); // read value
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text(message),
        ),
      ),
    );
  }
}
