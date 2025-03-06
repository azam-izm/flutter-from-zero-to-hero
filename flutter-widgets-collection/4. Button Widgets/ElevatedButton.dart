import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('ElevatedButton Variants')),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ElevatedButton(
                onPressed: () {},
                child: const Text('Basic Elevated Button'),
              ),
              const SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.thumb_up),
                label: const Text('With Icon'),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green, // Background color
                  foregroundColor: Colors.white, // Text color
                  padding:
                      const EdgeInsets.symmetric(vertical: 80, horizontal: 80),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                ),
                child: const Text('Styled Elevated Button'),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  elevation: 5, // Shadow depth
                  minimumSize:
                      const Size(200, 50), // Minimum size for width and height
                  side: const BorderSide(
                      color: Colors.blue, width: 2), // Border color and width
                ),
                child: const Text('Styled with Border and Elevation'),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple, // Background color
                  foregroundColor: Colors.black,
                  shape: const CircleBorder(), // Circular button
                  padding: const EdgeInsets.all(50), // Padding around the text
                ),
                child: const Text('Circular Elevated Button'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
