import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Tooltip Example',
      home: TooltipExample(),
    );
  }
}

class TooltipExample extends StatelessWidget {
  const TooltipExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tooltip Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Tooltip(
              message: 'This is a save icon.',
              child: IconButton(
                icon: const Icon(Icons.save),
                onPressed: () {
                  print('Save button clicked');
                },
              ),
            ),
            const SizedBox(height: 20),
            Tooltip(
              message: 'This is a delete icon.',
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(10),
              ),
              textStyle: const TextStyle(color: Colors.white),
              preferBelow: false, // Show the tooltip above the widget
              child: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  print('Delete button clicked');
                },
              ),
            ),
            const SizedBox(height: 20),
            Tooltip(
              message:
                  'This is a long text explaining this button in detail. Tooltips are useful for providing extra context.',
              child: ElevatedButton(
                onPressed: () {
                  print('Elevated button clicked');
                },
                child: const Text('Click Me'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
