import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Slider Widget Example',
      home: SliderExample(),
    );
  }
}

class SliderExample extends StatefulWidget {
  const SliderExample({Key? key}) : super(key: key);

  @override
  State<SliderExample> createState() => _SliderExampleState();
}

class _SliderExampleState extends State<SliderExample> {
  double _sliderValue = 20.0; // Initial value of the slider

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Slider Button Example'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text('Select Volume'),
            Slider(
              value: _sliderValue, // Current value of the slider
              min: 0.0, // Minimum value of the slider
              max: 100.0, // Maximum value of the slider
              divisions: 10, // Divides the slider into discrete intervals
              label: '${_sliderValue.toInt()}', // Displays the value as a label
              onChanged: (double value) {
                setState(() {
                  _sliderValue = value; // Updates the slider value
                });
              },
              activeColor:
                  Colors.blue, // Color of the active part of the slider
              inactiveColor:
                  Colors.grey, // Color of the inactive part of the slider
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text('Volume set to ${_sliderValue.toInt()}')),
                );
              },
              child: const Text('Set Volume'),
            ),
          ],
        ),
      ),
    );
  }
}
