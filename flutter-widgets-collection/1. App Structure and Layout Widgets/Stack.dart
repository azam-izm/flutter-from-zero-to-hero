import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stack Widget Example',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Stack Demo'),
        ),
        body: Center(
          child: Stack(
            alignment:
                Alignment.center, // Align children in the center of the stack
            children: [
              Container(
                width: 200,
                height: 200,
                color: Colors.blue,
              ),
              Container(
                width: 150,
                height: 150,
                color: Colors.green.withOpacity(0.7),
              ),
              Container(
                width: 100,
                height: 100,
                color: Colors.red.withOpacity(0.7),
                child: const Center(
                  child: Text(
                    'Top Widget',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
