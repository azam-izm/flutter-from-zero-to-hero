import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FloatingActionButton Widget Example',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('FAB Demo'),
        ),
        body: const Center(
          child: Text('Press the Floating Action Button!'),
        ),
        floatingActionButton: Padding(
          padding:
              const EdgeInsets.only(bottom: 16.0), // Add padding at the bottom
          child: FloatingActionButton(
            onPressed: () {
              // Action when button is pressed
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text('Floating Action Button Pressed!')),
              );
            },
            tooltip: 'Add Item',
            backgroundColor: Colors.blue, // Background color of the FAB
            foregroundColor: Colors.white, // Icon/Text color on the FAB
            splashColor: Colors.black, // Splash effect color when tapped
            elevation: 8.0, // Elevation to give a shadow effect
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16.0)),
            ),
            child: const Icon(Icons.add), // Icon for the FAB
          ),
        ),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.centerDocked, // Center bottom location
      ),
    );
  }
}
