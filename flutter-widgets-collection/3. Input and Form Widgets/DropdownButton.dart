import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DropdownButton Widget Example',
      home: const DropdownButtonExample(),
    );
  }
}

class DropdownButtonExample extends StatefulWidget {
  const DropdownButtonExample({Key? key}) : super(key: key);

  @override
  State<DropdownButtonExample> createState() => _DropdownButtonExampleState();
}

class _DropdownButtonExampleState extends State<DropdownButtonExample> {
  String _selectedValue = 'Apple'; // Default selected value
  final List<String> _fruits = ['Apple', 'Banana', 'Orange', 'Grapes']; // Dropdown options

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DropdownButton Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Select your favorite fruit:'),
            const SizedBox(height: 10),
            DropdownButton<String>(
              value: _selectedValue, // Current selected value
              items: _fruits.map((String fruit) {
                return DropdownMenuItem<String>(
                  value: fruit,
                  child: Text(fruit),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedValue = newValue!;
                });
              },
              icon: const Icon(Icons.arrow_drop_down), // Dropdown icon
              iconSize: 24, // Size of the icon
              elevation: 8, // Elevation of the dropdown menu
              style: const TextStyle(color: Colors.blue, fontSize: 16), // Text style
              dropdownColor: Colors.white, // Background color of the dropdown menu
              underline: Container(
                height: 2,
                color: Colors.blue, // Underline color
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('You selected: $_selectedValue')),
                );
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
