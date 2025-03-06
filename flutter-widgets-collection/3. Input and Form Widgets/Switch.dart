import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Switch Widget Example',
      home: SwitchExample(),
    );
  }
}

class SwitchExample extends StatefulWidget {
  const SwitchExample({Key? key}) : super(key: key);

  @override
  State<SwitchExample> createState() => _SwitchExampleState();
}

class _SwitchExampleState extends State<SwitchExample> {
  bool _isSwitched = false; // Tracks the state of the switch

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Switch Button Example'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text('Enable Notifications'),
            Switch(
              value: _isSwitched, // Current state of the switch (on/off)
              onChanged: (bool value) {
                setState(() {
                  _isSwitched = value; // Updates the state when toggled
                });
              },
              activeColor: Colors.green, // Color when the switch is on
              activeTrackColor:
                  Colors.lightGreen, // Track color when switch is on
              inactiveThumbColor:
                  Colors.red, // Thumb color when the switch is off
              inactiveTrackColor: Colors.grey, // Track color when switch is off
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                String status = _isSwitched ? 'enabled' : 'disabled';
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Notifications are $status')),
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
