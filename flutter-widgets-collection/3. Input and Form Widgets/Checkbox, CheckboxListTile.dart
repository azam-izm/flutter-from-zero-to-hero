import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Checkbox & CheckboxListTile Example',
      home: CheckboxExample(),
    );
  }
}

class CheckboxExample extends StatefulWidget {
  const CheckboxExample({Key? key}) : super(key: key);

  @override
  State<CheckboxExample> createState() => _CheckboxExampleState();
}

class _CheckboxExampleState extends State<CheckboxExample> {
  bool _isCheckboxChecked = false; // State for standalone Checkbox
  bool _isListTileChecked = false; // State for first CheckboxListTile
  bool _isSecondListTileChecked = false; // State for second CheckboxListTile

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkbox Demo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Standalone Checkbox'),
                Checkbox(
                  value: _isCheckboxChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      _isCheckboxChecked = value ?? false;
                    });
                  },
                  activeColor: Colors.blue,
                  checkColor: Colors.white,
                  side: const BorderSide(color: Colors.grey, width: 2),
                  splashRadius: 20.0,
                ),
              ],
            ),
            const SizedBox(height: 20),
            CheckboxListTile(
              title: const Text('Checkbox with Label'),
              subtitle: const Text(
                  'This is a CheckboxListTile with additional context.'),
              secondary: const Icon(Icons.info),
              value: _isListTileChecked,
              onChanged: (bool? value) {
                setState(() {
                  _isListTileChecked = value ?? false;
                });
              },
              activeColor: Colors.blue,
              checkColor: Colors.white,
              controlAffinity:
                  ListTileControlAffinity.leading, // Checkbox on the left
              dense: true, // Compact layout
              tileColor: _isListTileChecked
                  ? Colors.blue.shade50
                  : null, // Background color
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            const SizedBox(height: 20),
            CheckboxListTile(
              title: const Text('Another Checkbox with Label'),
              subtitle: const Text('This is another CheckboxListTile example.'),
              secondary: const Icon(Icons.settings),
              value: _isSecondListTileChecked,
              onChanged: (bool? value) {
                setState(() {
                  _isSecondListTileChecked = value ?? false;
                });
              },
              activeColor: Colors.green,
              checkColor: Colors.white,
              controlAffinity:
                  ListTileControlAffinity.trailing, // Checkbox on the right
              dense: true, // Compact layout
              tileColor: _isSecondListTileChecked
                  ? Colors.green.shade50
                  : null, // Background color
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
