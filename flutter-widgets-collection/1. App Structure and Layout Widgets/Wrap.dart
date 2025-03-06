import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wrap Widget Example',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Wrap Demo'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Wrap(
            direction: Axis.vertical,
            spacing: 8.0, // Space between adjacent items
            runSpacing: 4.0, // Space between lines
            children: List.generate(50, (index) {
              return Chip(
                label: Text('Item ${index + 1}'),
                backgroundColor: Colors.blueAccent,
                labelStyle: const TextStyle(color: Colors.white),
              );
            }),
          ),
        ),
      ),
    );
  }
}
