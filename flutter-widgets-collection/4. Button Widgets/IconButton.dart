import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'IconButton Widget Example',
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('IconButton Demo'),
        backgroundColor: Colors.amber,
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              // Action when the button is pressed
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Favorite Pressed!')),
              );
            },
            iconSize: 30.0, // Set the size of the icon
            color: Colors.pink, // Icon color
            padding: const EdgeInsets.all(15), // Padding around the icon
            splashColor: Colors.yellow, // Splash color when pressed
            highlightColor: Colors.black, // Highlight color on tap
            disabledColor: Colors.grey, // Disabled color for the icon
            tooltip: 'Favorite Icon', // Tooltip when hovering
            splashRadius: 25.0, // Radius of the splash effect
          ),
        ],
      ),
      body: const Center(
        child: Text('Press the icon in the app bar.'),
      ),
    );
  }
}
