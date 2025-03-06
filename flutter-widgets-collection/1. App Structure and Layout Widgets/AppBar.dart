import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'AppBar Example',
      home: AppBarExample(),
    );
  }
}

class AppBarExample extends StatelessWidget {
  const AppBarExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AppBar Example'),
        centerTitle: true, // Centers the title text
        backgroundColor: Colors.teal, // Sets the background color
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            // Add functionality for the menu icon
          },
        ), // Adds a navigation menu icon
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Add functionality for search
            },
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              // Add functionality for more options
            },
          ),
        ], // Adds icons on the right side of the AppBar
        elevation: 4.0, // Adds shadow depth
        shadowColor: Colors.grey, // Shadow color
      ),
      body: const Center(
        child: Text('Hello, AppBar!'),
      ),
    );
  }
}
