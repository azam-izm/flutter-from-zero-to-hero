import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Segmented Button',
      home: SegmentedButtonExample(),
    );
  }
}

class SegmentedButtonExample extends StatefulWidget {
  @override
  _SegmentedButtonExampleState createState() => _SegmentedButtonExampleState();
}

class _SegmentedButtonExampleState extends State<SegmentedButtonExample> {
  
  Set<int> selectedValues = {0};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal, 
        title: Text('Multi-Select Segmented Button'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title for the segmented button
            Text(
              'Choose categories:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            
            
            SegmentedButton<int>(
              multiSelectionEnabled: true,
              emptySelectionAllowed: true,
              showSelectedIcon: false,
              segments: [
                ButtonSegment<int>(
                  value: 0,
                  label: Row(
                    children: [
                      Icon(Icons.home, size: 18),
                      SizedBox(width: 5),
                      Text('Home'),
                    ],
                  ),
                ),
                ButtonSegment<int>(
                  value: 1,
                  label: Row(
                    children: [
                      Icon(Icons.search, size: 18),
                      SizedBox(width: 5),
                      Text('Search'),
                    ],
                  ),
                ),
                ButtonSegment<int>(
                  value: 2,
                  label: Row(
                    children: [
                      Icon(Icons.person, size: 18),
                      SizedBox(width: 5),
                      Text('Profile'),
                    ],
                  ),
                ),
              ],
              selected: selectedValues, 
              onSelectionChanged: (Set<int> newSelection) {
                setState(() {
                  selectedValues = newSelection;
                });
                print('Selected categories: $newSelection');
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith<Color>(
                  (states) {
                    if (states.contains(MaterialState.selected)) {
                      return Colors.teal.shade700; // Dark teal for selected
                    }
                    return Colors.grey.shade200; // Light grey for unselected
                  },
                ),
                foregroundColor: MaterialStateProperty.resolveWith<Color>(
                  (states) {
                    if (states.contains(MaterialState.selected)) {
                      return Colors.white; // White text for selected
                    }
                    return Colors.black; // Black text for unselected
                  },
                ),
              ),
            ),
            SizedBox(height: 20),

            // Display the selected categories
            Text(
              'You selected: ${selectedValues.map((e) => e == 0 ? "Home" : e == 1 ? "Search" : "Profile").join(", ")}',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
