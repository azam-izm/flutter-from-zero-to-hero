import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Radio Widget Example',
      home: RadioExample(),
    );
  }
}

class RadioExample extends StatefulWidget {
  const RadioExample({Key? key}) : super(key: key);

  @override
  State<RadioExample> createState() => _RadioExampleState();
}

class _RadioExampleState extends State<RadioExample> {
  int? _selectedValue = 0; // Initially selected radio button

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Radio Button Example'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text('Choose your favorite fruit:'),
            Row(
              children: [
                Radio<int>(
                  value: 0, // The value for this radio button
                  groupValue: _selectedValue, // The selected value of the group
                  onChanged: (int? value) {
                    setState(() {
                      _selectedValue = value; // Update selected value
                    });
                  },
                  activeColor: Colors.blue, // Color when selected
                ),
                const Text('Apple'),
              ],
            ),
            Row(
              children: [
                Radio<int>(
                  value: 1, // The value for this radio button
                  groupValue: _selectedValue,
                  onChanged: (int? value) {
                    setState(() {
                      _selectedValue = value;
                    });
                  },
                  activeColor: Colors.blue,
                ),
                const Text('Banana'),
              ],
            ),
            Row(
              children: [
                Radio<int>(
                  value: 2, // The value for this radio button
                  groupValue: _selectedValue,
                  onChanged: (int? value) {
                    setState(() {
                      _selectedValue = value;
                    });
                  },
                  activeColor: Colors.blue,
                ),
                const Text('Orange'),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                String selectedFruit = '';
                switch (_selectedValue) {
                  case 0:
                    selectedFruit = 'Apple';
                    break;
                  case 1:
                    selectedFruit = 'Banana';
                    break;
                  case 2:
                    selectedFruit = 'Orange';
                    break;
                }
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('You selected: $selectedFruit')),
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
