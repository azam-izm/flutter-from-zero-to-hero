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
          title: const Text('OutlinedButton Examples'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Basic OutlinedButton
              OutlinedButton(
                onPressed: () {
                  print('Basic OutlinedButton pressed!');
                },
                child: const Text('Basic OutlinedButton'),
              ),

              const SizedBox(height: 10),

              // OutlinedButton with icon using OutlinedButton.icon
              OutlinedButton.icon(
                onPressed: () {
                  print('OutlinedButton with icon pressed!');
                },
                icon: const Icon(Icons.thumb_up, color: Colors.green),
                label: const Text('Like'),
              ),

              const SizedBox(height: 10),

              // OutlinedButton with custom padding and border width
              OutlinedButton(
                onPressed: () {
                  print(
                      'OutlinedButton with custom padding and border width pressed!');
                },
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                      vertical: 50, horizontal: 25), // Custom padding
                  side: const BorderSide(color: Colors.orange, width: 2),

                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(16), // Custom rounded corners
                  ),
                ),
                child: const Text('Padding & Border'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
