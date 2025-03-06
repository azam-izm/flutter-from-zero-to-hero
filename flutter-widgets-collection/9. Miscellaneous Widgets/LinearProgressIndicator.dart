import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'LinearProgressIndicator Example',
      home: LinearProgressIndicatorExample(),
    );
  }
}

class LinearProgressIndicatorExample extends StatelessWidget {
  const LinearProgressIndicatorExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LinearProgressIndicator Example'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Indeterminate Progress Indicator
            const Text(
              'Indeterminate LinearProgressIndicator:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const LinearProgressIndicator(),
            const SizedBox(height: 30),

            // Determinate Progress Indicator
            const Text(
              'Determinate LinearProgressIndicator:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            LinearProgressIndicator(
              value: 0.7, // Progress value (70%)
              color: Colors.green,
              backgroundColor: Colors.grey[300],
              minHeight: 8.0,
            ),
          ],
        ),
      ),
    );
  }
}
