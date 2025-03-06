import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Column Widget Example',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Column Demo'),
        ),
        body: const Center(
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.center, // Align children vertically
            crossAxisAlignment:
                CrossAxisAlignment.center, // Align children horizontally
            children: [
              Icon(Icons.star, color: Colors.yellow, size: 50),
              SizedBox(height: 20), // Space between widgets
              Icon(Icons.favorite, color: Colors.red, size: 50),
              SizedBox(height: 20), // Space between widgets
              Icon(Icons.thumb_up, color: Colors.blue, size: 50),
            ],
          ),
        ),
      ),
    );
  }
}
