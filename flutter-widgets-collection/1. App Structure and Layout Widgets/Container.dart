import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Container Widget Example',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Container Demo'),
        ),
        body: Center(
          child: Container(
            width: 200.0,
            height: 200.0,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(16.0),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  offset: Offset(4.0, 4.0),
                  blurRadius: 10.0,
                ),
              ],
            ),
            alignment: Alignment.center,
            child: const Text(
              'Hello, Flutter!',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
