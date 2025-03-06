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
        body: Builder(
          builder: (context) {
            return Center(
              child: ElevatedButton(
                onPressed: () {
                  final message = SnackBar(
                    action: SnackBarAction(
                      label: 'DISMISS',
                      textColor: Colors.white,
                      onPressed: () {
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      },
                    ),
                    backgroundColor: Colors.grey[800],
                    content: const Text(
                      'This is a snack_bar',
                      style: TextStyle(color: Colors.white),
                    ),
                    duration: const Duration(seconds: 3),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(message);
                },
                child: const Text('showSnackBar'),
              ),
            );
          },
        ),
      ),
    );
  }
}
