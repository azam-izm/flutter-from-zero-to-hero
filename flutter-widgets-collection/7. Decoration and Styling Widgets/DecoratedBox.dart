import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'DecoratedBox Example',
      home: DecoratedBoxExample(),
    );
  }
}

class DecoratedBoxExample extends StatelessWidget {
  const DecoratedBoxExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DecoratedBox Example'),
      ),
      body: Center(
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.blue, // Background color
            borderRadius: BorderRadius.circular(15), // Rounded corners
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5), // Shadow color
                offset: const Offset(4, 4), // Shadow offset
                blurRadius: 8, // Shadow blur radius
              ),
            ],
          ),
          child: const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Decorated Box',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
