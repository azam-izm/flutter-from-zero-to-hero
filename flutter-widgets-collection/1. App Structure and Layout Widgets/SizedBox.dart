import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SizedBox Widget Example',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('SizedBox Demo'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 100,
                height: 100,
                color: Colors.blue,
              ),
              const SizedBox(
                  height: 20), // Adds space between the two containers
              Container(
                width: 100,
                height: 100,
                color: Colors.green,
              ),
              const SizedBox(
                  width: 50), // Adds space between the containers horizontally
              Container(
                width: 100,
                height: 100,
                color: Colors.red,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
