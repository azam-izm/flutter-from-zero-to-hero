import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'SingleChildScrollView Example',
      home: SingleChildScrollViewExample(),
    );
  }
}

class SingleChildScrollViewExample extends StatelessWidget {
  const SingleChildScrollViewExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SingleChildScrollView Example'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildCard(Colors.red, 'Item 1'),
            _buildCard(Colors.green, 'Item 2'),
            _buildCard(Colors.blue, 'Item 3'),
            _buildCard(Colors.orange, 'Item 4'),
            _buildCard(Colors.purple, 'Item 5'),
            _buildCard(Colors.yellow, 'Item 6'),
            _buildCard(Colors.teal, 'Item 7'),
            _buildCard(Colors.brown, 'Item 8'),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(Color color, String text) {
    return Card(
      color: color,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
