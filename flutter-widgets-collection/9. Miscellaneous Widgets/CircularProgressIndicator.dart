import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'CircularProgressIndicator Example',
      home: CircularProgressIndicatorExample(),
    );
  }
}

class CircularProgressIndicatorExample extends StatelessWidget {
  const CircularProgressIndicatorExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CircularProgressIndicator Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Indeterminate Progress Indicator
            const Text(
              'Indeterminate CircularProgressIndicator:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const CircularProgressIndicator(),
            const SizedBox(height: 30),

            // Determinate Progress Indicator
            const Text(
              'Determinate CircularProgressIndicator:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            CircularProgressIndicator(
              value: 0.75, // Progress value (75%)
              color: Colors.blue,
              backgroundColor: Colors.grey[300],
              strokeWidth: 8.0,
            ),
          ],
        ),
      ),
    );
  }
}
