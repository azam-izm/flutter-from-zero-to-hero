import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Icon Widget Example',
      home: const IconExample(),
    );
  }
}

class IconExample extends StatelessWidget {
  const IconExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Icon Widget Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Icons with Different Styles',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Icon(
              Icons.home, // Home icon
              size: 50, // Size of the icon
              color: Colors.blue, // Color of the icon
            ),
            const SizedBox(height: 20),
            const Icon(
              Icons.favorite, // Heart icon
              size: 50,
              color: Colors.red,
            ),
            const SizedBox(height: 20),
            IconButton(
              icon: const Icon(Icons.info),
              color: Colors.green,
              iconSize: 50,
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Info icon clicked!')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
