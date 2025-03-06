import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Text Widget Example',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Text Demo'),
        ),
        body: const Center(
          child: Text(
            'Hello, Flutter!',
            style: TextStyle(
              fontSize: 24, // Font size
              fontWeight: FontWeight.bold, // Font weight
              color: Colors.blue, // Text color
            ),
            textAlign: TextAlign.center, // Align text
          ),
        ),
      ),
    );
  }
}
