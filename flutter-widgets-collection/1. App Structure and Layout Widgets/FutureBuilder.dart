import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Future<String> fetchData() async {
    // Simulate a network request or async task
    await Future.delayed(const Duration(seconds: 3));
    return "Hello from the Future!";
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FutureBuilder Widget Example',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('FutureBuilder Demo'),
        ),
        body: Center(
          child: FutureBuilder<String>(
            future: fetchData(), // The async operation to perform
            builder: (context, snapshot) {
              // Check the connection state and data
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator(); // Show loading spinner
              } else if (snapshot.hasError) {
                return Text(
                  'Error: ${snapshot.error}',
                  style: const TextStyle(color: Colors.red),
                ); // Show error message
              } else if (snapshot.hasData) {
                return Text(
                  snapshot.data!,
                  style: const TextStyle(fontSize: 18),
                ); // Show fetched data
              }
              return const Text('No data found.');
            },
          ),
        ),
      ),
    );
  }
}
