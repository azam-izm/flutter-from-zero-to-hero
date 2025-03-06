import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Row Widget Example',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Row Demo'),
        ),
        body: const Center(
          child: Row(
            mainAxisAlignment:
                MainAxisAlignment.center, // Align children horizontally
            crossAxisAlignment:
                CrossAxisAlignment.center, // Align children vertically
            children: [
              Icon(Icons.star, color: Colors.yellow, size: 50),
              SizedBox(width: 20), // Space between widgets
              Icon(Icons.favorite, color: Colors.red, size: 50),
              SizedBox(width: 20), // Space between widgets
              Icon(Icons.thumb_up, color: Colors.blue, size: 50),
            ],
          ),
        ),
      ),
    );
  }
}
