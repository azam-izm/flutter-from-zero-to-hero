// ignore_for_file: avoid_print

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
        appBar: AppBar(
          title: const Text('TextButton Examples'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Basic TextButton
              TextButton(
                onPressed: () {
                  print('Basic TextButton pressed!');
                },
                child: const Text('Basic TextButton'),
              ),
              const SizedBox(height: 10),

              // TextButton with icon using TextButton.icon
              TextButton.icon(
                onPressed: () {
                  print('TextButton with icon pressed!');
                },
                icon: const Icon(Icons.thumb_up, color: Colors.green),
                label: const Text('Like'),
              ),

              const SizedBox(height: 10),

              TextButton(
                onPressed: () {
                  print('Custom shaped TextButton pressed!');
                },
                style: TextButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding:
                      const EdgeInsets.symmetric(vertical: 60, horizontal: 30),
                  side: const BorderSide(color: Colors.red, width: 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text('Custom Shape'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
