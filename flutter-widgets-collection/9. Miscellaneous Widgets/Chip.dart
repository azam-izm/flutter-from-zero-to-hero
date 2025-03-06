import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Chip Example',
      home: ChipExample(),
    );
  }
}

class ChipExample extends StatelessWidget {
  const ChipExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chip Example'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Example of a simple chip
            const Text(
              'Basic Chip:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Chip(
              label: Text('Basic Chip'),
            ),
            const SizedBox(height: 20),

            // Example of a chip with avatar (image/icon)
            const Text(
              'Chip with Avatar:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Chip(
              avatar: Icon(Icons.tag),
              label: Text('Chip with Icon'),
            ),
            const SizedBox(height: 20),

            // Example of a chip with a delete button
            const Text(
              'Chip with Deletion:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Chip(
              label: const Text('Delete Me'),
              onDeleted: () {
                // Action to delete chip (e.g., remove from list)
                print('Chip Deleted');
              },
              deleteIcon: const Icon(Icons.close),
            ),
            const SizedBox(height: 20),

            // Example of a choice chip (can be selected)
            const Text(
              'Choice Chip:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ChoiceChip(
              label: const Text('Choice Chip 1'),
              selected: true, // Whether the chip is selected
              onSelected: (bool selected) {
                print('Choice Chip 1 selected: $selected');
              },
            ),
          ],
        ),
      ),
    );
  }
}
