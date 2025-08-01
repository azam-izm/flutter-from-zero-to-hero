import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  // Step 1: Initialize Hive for Flutter
  await Hive.initFlutter();

  // Step 2: Open a Hive box (like a small database table)
  await Hive.openBox('myBox');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Step 3: Access the box we opened earlier
    var box = Hive.box('myBox');

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Hive Flutter Demo')),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              TextField(
                controller: _controller,
                decoration: const InputDecoration(labelText: 'Enter something'),
              ),

              // Step 4: Button to save input to Hive box
              ElevatedButton(
                onPressed: () {
                  // Save data using key 'myData'
                  box.put('myData', _controller.text);
                },
                child: const Text('Save'),
              ),

              const SizedBox(height: 20),

              // Step 5: Show the saved value on the screen
              // This will automatically update when the value changes
              ValueListenableBuilder(
                valueListenable: box.listenable(),
                builder: (context, Box box, _) {
                  // Read value using key 'myData'
                  String value = box.get('myData', defaultValue: 'No data yet');
                  return Text('Saved: $value');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
