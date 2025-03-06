import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RichText Widget Example',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('RichText Demo'),
        ),
        body: Center(
          child: RichText(
            text: const TextSpan(
              style: TextStyle(
                fontSize: 24,
                color: Colors.black,
              ),
              children: <TextSpan>[
                TextSpan(text: 'Hello, '),
                TextSpan(
                  text: 'Flutter ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                TextSpan(
                  text: 'Developers!',
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
