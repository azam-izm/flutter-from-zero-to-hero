import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Spacer Widget Example',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Spacer Demo'),
        ),
        body: const Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.star, color: Colors.yellow, size: 50),
              Spacer(), // Adds flexible space between the icons
              Icon(Icons.favorite, color: Colors.red, size: 50),
              Spacer(), // Adds more flexible space between the icons
              Icon(Icons.thumb_up, color: Colors.blue, size: 50),
            ],
          ),
        ),
      ),
    );
  }
}
