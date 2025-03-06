import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Align Widget Example',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Align Demo with Stack'),
        ),
        body: Center(
          child: Container(
            width: 300,
            height: 300,
            color: Colors.red[300], // Background for visibility
            child: Stack(
              children: [
                // Background image or color
                Positioned.fill(
                  child: Image.network(
                    'https://img.freepik.com/free-photo/blue-green-abstract-wallpaper-that-says-sea_1340-35745.jpg?t=st=1735092725~exp=1735096325~hmac=dc4627766b71a8fb6b6dd76a84d9f3c74331f89d2044c48e3be09aab1e5119b5&w=740',
                    fit: BoxFit.cover,
                  ),
                ),
                // Top-left corner text
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    color: Colors.black54,
                    child: const Text(
                      'Top Left',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                // Bottom-right corner text
                Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    color: Colors.black54,
                    child: const Text(
                      'Bottom Right',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                // Center text
                const Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Center',
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
